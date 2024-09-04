Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F30CD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpE1-0006LH-Gm; Wed, 04 Sep 2024 08:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slpDy-0006Kn-NH
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slpDx-0000kh-9g
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725453299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G0d2Ftw1keF+MecVccHVBUEJn6uLHHjgQh3Tc33KnfM=;
 b=PyWCUKSpcdHqbkiAzE0ME/xXEZXF4h/Y/kEMF63GrVxDOWW+3LwBFs9ytDLqhN2z+2fdrA
 lcpJB2lsmbOY96ArnyrSw+5GV5IwDQl3n6h+uDAzs+1cN/L1uM/mKHwWRA7bD+TrPw6gNo
 z0ZmBoLYIhn//cTVEobuszxzP1ZGaXg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-7djdySjrOVqQ6Bbe53RDHQ-1; Wed, 04 Sep 2024 08:34:58 -0400
X-MC-Unique: 7djdySjrOVqQ6Bbe53RDHQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2f40231302cso14346511fa.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 05:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725453297; x=1726058097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G0d2Ftw1keF+MecVccHVBUEJn6uLHHjgQh3Tc33KnfM=;
 b=NdnZs1Iv0n2U17rRYyTlBqPjjVHy9Gcuw8mK7C8oDVyEnxmkBnI48gvSvmJPnN+zoq
 p7xiuvlzgAh78IF0g2C7LEI0ej/X+Y7l1yjtsPO36u99p7bYT9sV7ErUry9N1NdD3uV1
 ZSoo0SyuORM+UbbndIW1wRGOwFCXWSFFp5w1TXyzNCdeDcgqupRfGf0NxJXJQXQ6kbGy
 LNDN/CxA6CyeN8Dh29ONqknL7ImWzvK3eUHjVpsxwxIPGPE6N+5C2w1FFvfR45JwYkMe
 U5GNgs/bvvWNRFsK1g8bJM2mkluw4Vm2VawkbYGx9JsQkz++BzmbJJvFiEqFH+S11N2Y
 n7Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoNowJuLDzOmEumrLKq1ilu3V8sLP1m20tLzSk2owuB7xzXdNU+A7K475sISKxw4/KlWXUWkDjRRTo@nongnu.org
X-Gm-Message-State: AOJu0YwqncUJeIJC79gzKiU3Um/+WMzhpyt1g2LxKbxLwCstHQDOefiw
 4F2Tqm0uiqTIfuHyxawkj1+jtG+BEax//pdkxov9FcFXPNwUqQjOZvfUllhO6NFn+HFlvQ80lI8
 ZcWNb1C4uh0MS+vx5qSRZKdkd4kfbCbfVorFgkJVy0lNM9aJ9Qyqh
X-Received: by 2002:a05:651c:547:b0:2ef:1b1f:4b4f with SMTP id
 38308e7fff4ca-2f6104f259bmr138053221fa.34.1725453296960; 
 Wed, 04 Sep 2024 05:34:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoRBDHPavq6UA0kKQTAAAvezahr5ruud7mw7u5FPzMvT3688Ku6QSAG1c69iTWmJdtOmQO5A==
X-Received: by 2002:a05:651c:547:b0:2ef:1b1f:4b4f with SMTP id
 38308e7fff4ca-2f6104f259bmr138052911fa.34.1725453296364; 
 Wed, 04 Sep 2024 05:34:56 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c24f0ed6d6sm4690183a12.90.2024.09.04.05.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 05:34:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: zhao1.liu@intel.com,
	kvm@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: Re: [PATCH v2] kvm: refactor core virtual machine creation into its
 own function
Date: Wed,  4 Sep 2024 14:34:49 +0200
Message-ID: <20240904123448.284294-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240808113838.1697366-1-anisinha@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Queued (with conflicts fixed), thanks.

Paolo


