Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A259ACD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slozT-0003A5-6t; Wed, 04 Sep 2024 08:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slozR-00032c-1x
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:20:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slozP-0003YY-Nv
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725452399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KGc9QvgVjoaSl0dkn+SZMT3QL+bj6GOpB2lwOgIcp6o=;
 b=c83SEgBUEYZZjbLxluBmESkPl5YRN8bIftKPRVcnwZB7JYQAL+EHemHeJY4lfJ0mMhmvl+
 2sqX8ZDHPSzk54Da8YLabpJHsTTHM9otJ4EtmSLOlj492tPzBXQdAneHYiEWhQcS0s0or6
 ybIalrEcdPnbFL8EZrapXg3K57BUVJU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633--5_vHGdcM7OhjUOGqKuePw-1; Wed, 04 Sep 2024 08:19:57 -0400
X-MC-Unique: -5_vHGdcM7OhjUOGqKuePw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37496a7daf2so4356775f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 05:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725452397; x=1726057197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KGc9QvgVjoaSl0dkn+SZMT3QL+bj6GOpB2lwOgIcp6o=;
 b=ZAecHSf4gA7IJLPpn/w06HmmOcfOE/fOKkLCg6JQro0Dy2boxqKLmJtrdM07dlQZAj
 EgDRHtH9D28QBGc1TmVbLdYeE7ssGssIkHHMipO0hunhUWQtfiRAtTfmpby+fZwaFIfI
 sV7i89qfhwSyg67yhCUKF6bwsOxl7DzvozTyC4BUKS2SQd+KIDiBK0oIVjQkNZNrnTBy
 LbQlPeGCnvMSdYhsoWfv2MpaSPexikQ4w0qU5J/Iu8rBVHaKS2BGRs9i5BInhWD1HrGU
 6JQnxLTZXjY3EorGtPNPKBpe/8vMUkmVT7rwHsMp4p0k15epCou4NpVyuAfvyT8TRxeJ
 9A4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUywkZktZkr5D2td/jmF/g18tHhALYa/81BUQbHoC7VdbemW1I1p1isoqquoce7v6WD9g/AT0PCLXWG@nongnu.org
X-Gm-Message-State: AOJu0YyHF/2BxzkNhs8xa71AhzjoLlk3PcbWidd2O8QKG369T8bU3zvY
 xQY2XoAqzB4K6A2bFZw1AVaGDhER5sUXSSLJm5CXGYBNzdgpbyJPmrOLBI40KtQ3mnC07YCoNrp
 /5KhaRIlVFnwX5vp4qXqKH51W6Z0m6OmpWaiGVTBK/glU9wQSMUqn
X-Received: by 2002:adf:a1cb:0:b0:374:c621:3d67 with SMTP id
 ffacd0b85a97d-376dd15b0a7mr2823661f8f.24.1725452396779; 
 Wed, 04 Sep 2024 05:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF/wW82ITfaCikjadIhPTRcqk1hrsgEFwumuQ0D3K+BIDsIED106IQiBx9UCgCO4pD5MjwgQ==
X-Received: by 2002:adf:a1cb:0:b0:374:c621:3d67 with SMTP id
 ffacd0b85a97d-376dd15b0a7mr2823640f8f.24.1725452396207; 
 Wed, 04 Sep 2024 05:19:56 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c24ace8128sm5081591a12.30.2024.09.04.05.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 05:19:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] kvm/i386: fix return values of is_host_cpu_intel()
Date: Wed,  4 Sep 2024 14:19:20 +0200
Message-ID: <20240904121919.280127-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903080004.33746-1-anisinha@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Queued, thanks (reverting the bool->gboolean change; QEMU does not use
g* types and they are kinda deprecated in glib too).

Paolo


