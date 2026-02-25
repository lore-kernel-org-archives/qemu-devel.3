Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A61F55452
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5v4-0007ME-Nm; Tue, 24 Feb 2026 22:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5v3-0007Lc-2N
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5v1-000879-Kc
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UqlV2b27E+aarYMd02lMV5j2FrXQhhHTUbSjNbHXroY=;
 b=g3FruLZZVqlP6Nwv0D9SBu43n//I+1KVyl3+P6iBKHg7eABrvorNMTuKK4CHwtNLiiKwkb
 IwBVO9R9Zt4MOUl3UuMqkwn/oGXSuvDZB2gWxGun2aIY7X5IBN7o5h+SqcKxpxh5ePstiV
 oo4YlbmtP2OG/s8hqkbMGw2xVxP58nM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-sEouuQ8iM7eLLkqXLyiJQQ-1; Tue, 24 Feb 2026 22:50:30 -0500
X-MC-Unique: sEouuQ8iM7eLLkqXLyiJQQ-1
X-Mimecast-MFC-AGG-ID: sEouuQ8iM7eLLkqXLyiJQQ_1771991429
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-354c0234c1fso5707793a91.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991429; x=1772596229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UqlV2b27E+aarYMd02lMV5j2FrXQhhHTUbSjNbHXroY=;
 b=Kh5NRxIH7BuHHXaAQsNjc1Zu9L+Hmi/kyaTXNgunIKIYzj7wbAnXVjLgAxruTZWehV
 cUqSsqiKE1XdXJXRxJsU0svmb2C/xLEpTpvhr4Ii8hY20/gMVb5FsK+GR7fzusNyOKku
 wRm0qu39boz3N+H9XDhAkvntwgZ9QO+i1UJGcd2sKD9UhDv6NogTJAHuIdjlUqXBCgeu
 GcdVXwu5WenzKSv9kocx73SRSdr2Z7dL3i4SQ+obUVFEM84M0izVQLui/qS+rHsZiFSz
 m82RgrRUSoqq1lN1qYP3ysMxUwJuJI3iGMegsdLHzuLRacPMMM+3QVXBS6n6FhoTjKc8
 hgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991429; x=1772596229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UqlV2b27E+aarYMd02lMV5j2FrXQhhHTUbSjNbHXroY=;
 b=uJWQ8lNi4FWfTtKIpF9L8XFRE0yua76cvyasBLZ7Fp9AwsJCygS9Q6nPwVZjd6bsXZ
 ue3QcsP/HLGXz4KIu60rJqROmjVItDQ2RnmG/y2LYzHDI17opG+0mqvUwzxpYl9Wvoth
 6dXleTw0fpDeqEhKe6F8fEsXLhOMbJCLnrlWMSL7kTW4x6Iz+TA+4p+YjQm3QHkuDkKp
 pAFGJ/75yalz0yjRpdV+kleRyxAs6Evzp2i68cE2oZFYUPK9IuQeGnUb9UDfLkmy96lc
 Ybsr2jLsxKgxuP1PLs5ZP46h1CR6XRdsPFOLywopPyV85ucrqfuqE7YN8vk7R6Xi0dIf
 MUNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzM6qh9nfCNRh8J0pp/BpnVHh7oDp7y499AnCDXwmgURXQQWJezRrTSHddvdrF+hdUyMLge69thz4g@nongnu.org
X-Gm-Message-State: AOJu0Yzx2uztyneukc8mim8khYLBBmLdzZf7uS8RvSaw7UEjdyhaOETU
 z5N83HPUtWGajpMKZfw9hsRDMyHEX27yOcs/nZvpdgJfXf+FbhzCf+Qt+H5UWLVJfniJsitUL7b
 TQKo/FqT8sSwcJSyuB1aLZhQBHiHtp8zAL1jEQimHsQm0214LwTNwN0dc
X-Gm-Gg: ATEYQzxSq1y1lHf88hQ/csyPc2BbvBpqlO/Yq5uQ6xbf7E114rg11ifDLBf24shzr8S
 5obAaKavbDs9Nx6AcYGbXFMYo5DMbBftJhXYnYGxDmo/s+iDYy8y19JaXPdBLaVj0iiladpjWLu
 gE1BvnZBTadBk2uRlBelBgOSHr2qaezwgYg7S3we23QNnt6E9DXYN8qMewMFHlfTK0TmMsWYrMv
 DvOaRxyr+VZ210whCq3M/4S9EiPH1z1nfz0yayyJNS/SIxg5I+WcCT7ETMUVUuZcXP3VYvsgOqn
 hW1ngqlSQu/24FQ3LN+X1dGVTBDSl3bDCJOINamk+zjSXq7XBukQRYaNUexP7eiKrCb2Xd2huaE
 0t/xpTDmgu4wzqDKn0+PbSTimh7YH33I6BihCmFnjrnEoqkhbtc9gsYc=
X-Received: by 2002:a17:90b:1f88:b0:354:bd08:4802 with SMTP id
 98e67ed59e1d1-3590f27b7fcmr824599a91.35.1771991429135; 
 Tue, 24 Feb 2026 19:50:29 -0800 (PST)
X-Received: by 2002:a17:90b:1f88:b0:354:bd08:4802 with SMTP id
 98e67ed59e1d1-3590f27b7fcmr824586a91.35.1771991428782; 
 Tue, 24 Feb 2026 19:50:28 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:50:28 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v6 06/35] accel/kvm: mark guest state as unprotected after vm
 file descriptor change
Date: Wed, 25 Feb 2026 09:19:11 +0530
Message-ID: <20260225035000.385950-7-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When the KVM VM file descriptor has changed and a new one created, the guest
state is no longer in protected state. Mark it as such.
The guest state becomes protected again when TDX and SEV-ES and SEV-SNP mark
it as such.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index cc5c42ce4d..096edb5e19 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2650,6 +2650,9 @@ static int kvm_reset_vmfd(MachineState *ms)
 
     s->vmfd = ret;
 
+    /* guest state is now unprotected again */
+    kvm_state->guest_state_protected = false;
+
     kvm_setup_dirty_ring(s);
 
     /* rebind memory to new vm fd */
-- 
2.42.0


