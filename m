Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F80CFD2EB
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 08:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szBNJ-0005Zm-Ab; Fri, 11 Oct 2024 04:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szBNH-0005Un-Nb
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 04:51:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szBNG-0007Yj-D7
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 04:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728636708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PYZIH1835haa67HCCPbZ8XMH65EjXy4XQri9iGj1jvY=;
 b=gLGgAg4r9agladjZoBG3iqXGm8CUzkb2/2VpTzq7LoHOtc5oYqaaYEQD8o9BMY5cVO3zMz
 32leTm15EeLJNBjDNkEtrCCkBejJneIuuFs4AoqaI7rMqfncS0ya7ODjBJPl8lOeQ4Y5FG
 0BAKRksXDRm+IBZE9ncuoBltOlhJl/M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-i4YQ7SSkOWemIDFxgXWTfw-1; Fri, 11 Oct 2024 04:51:47 -0400
X-MC-Unique: i4YQ7SSkOWemIDFxgXWTfw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a7d2d414949so125950366b.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 01:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728636706; x=1729241506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PYZIH1835haa67HCCPbZ8XMH65EjXy4XQri9iGj1jvY=;
 b=aUHZF7kY/ZnPUL2LmYt3RovBEwsnB3/2+6XwtjP3fXJbM4PeH0LvKX0Z1D6tazzkMW
 9eaVgsP1iNRGbC3cfSF1bk4Rrc9QK2G4FGbvXpir9U8L4beDUfLaRIxlnBVADJcb6oBU
 mFyyskpr5tMtfklBFV2qY4djqZoEuqVP8orT1sjPviLcGCg/yyWWaiJEaIF6P+4iXMem
 Kvl1bhBS/yC9xK7g1u48cI/GraIPitiXPv12hX0uiVg1NQ6ojLZGY9Ex8qcKvk/EV/Sp
 554epjtDZuIQh2CbDAuu94qwsM75UEmOkWyNX2z9Py2ffaJVO57Lc84Irk9XJik9f5w+
 B7gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHUXXytsz9AjotSEZQ9Rys7JOL9xZoovNar6Bn74+LB9dP3OXZvP+IOV5c76eE/v4PMQ26pILE92OI@nongnu.org
X-Gm-Message-State: AOJu0YxInJ4p15yEdQnwqAZsoIjEVbIrTinSMjwNdK96LFy2Jgj/Uev2
 EvzWvldjQg1uoZ1X9Kw6/gvR7JZxPsc/7F+TEkWHP3xIuNefsQYwG/J6uI3FjRENdeQhVY6GtDC
 fH7PjbrlKgUt9rYE+bRQfRLlEhHh0DG49AsN06rdVvfSKCZa6bx7A
X-Received: by 2002:a17:907:96aa:b0:a99:4261:e9f7 with SMTP id
 a640c23a62f3a-a99b940efe8mr138334866b.39.1728636706009; 
 Fri, 11 Oct 2024 01:51:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjLkR6KNnfNDTe6MGrn/erNOc00pK6j16hOkFKiGM79jmUYrioihBFa9FPpA0bo9mcFzzNrA==
X-Received: by 2002:a17:907:96aa:b0:a99:4261:e9f7 with SMTP id
 a640c23a62f3a-a99b940efe8mr138333166b.39.1728636705577; 
 Fri, 11 Oct 2024 01:51:45 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80dc687sm189074066b.147.2024.10.11.01.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 01:51:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Tom Dohrmann <erbse.13@gmx.de>
Cc: kvm@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: Re: [PATCH] accel/kvm: check for KVM_CAP_READONLY_MEM on VM
Date: Fri, 11 Oct 2024 10:51:11 +0200
Message-ID: <20241011085110.20303-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240903062953.3926498-1-erbse.13@gmx.de>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Queued, thanks.  (Sorry about the message I have just sent with your
patch, I used the wrong script!)

Paolo


