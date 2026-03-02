Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E4FD58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvg-0007tq-0D; Mon, 02 Mar 2026 03:47:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyup-0005Ne-Hc
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyul-0001w4-Jy
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7AROvJv5T7divz4u09Cm1O0cyo+YUynxqWVLfSDj/jQ=;
 b=O16tE3Hntc9zUXI7BFdgmQVXwaJCrzWHeS6n0Bg2gNAPd+kEsG95YVAMNcfajALMC7076g
 0fKwpefIO8I0lHTFOCmBY9QXu3oYlijWUixLA6DtinBnWbjYJ6rx6qDulLn54k+lN3dZFr
 yzIzFe8fUaHiZAggZyE2v74KWfpg6uw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-Hd_0i9PCMUayFAgHqMwgDQ-1; Mon, 02 Mar 2026 03:45:47 -0500
X-MC-Unique: Hd_0i9PCMUayFAgHqMwgDQ-1
X-Mimecast-MFC-AGG-ID: Hd_0i9PCMUayFAgHqMwgDQ_1772441146
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso53791275e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441145; x=1773045945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7AROvJv5T7divz4u09Cm1O0cyo+YUynxqWVLfSDj/jQ=;
 b=Dt/0j4WLqwQEfD5+USYb+HQlasoTeJdM8rsNHziiFzH2Wch9Exiqgjtkfo2OE4U7cT
 WJPslNdLZeoRbrq40FszQ1ayBACrChI1zC0Xc0u6v+ukKVDtS2a+G+GSNBH3+mCOMjDJ
 EV+vuN51uxg4KQ7dBhEuptsjKi4pLMFH+ViNWjUKnbh9iFBag9KDVI882Lsz+2W45itf
 vr0w5xOFh0TKbTr5vbNduDt74P/5rFRmQPhhqLn/nEygYzAujKjnBy1SwWqBbppVLf4G
 mJDrjiknbZTDlypBO94F5mlF2+b8XgZhitoyz6oUBA2Wjz3Q17E3QorgrVpEuiW4zLzn
 gQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441145; x=1773045945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7AROvJv5T7divz4u09Cm1O0cyo+YUynxqWVLfSDj/jQ=;
 b=jgo04Zeh/Lrrlby/2LnFY2ri3rWurtJQsYhWXKJiA+vdgiaU1Co/mDqLRMOCjJZyoj
 aujqt1ksMoZUggL45kgi8P5vrOFRg+FazA57Ux5CRPqzukba05ss0+Cz9wG1MyDFLCbN
 jy/XAnhl3IujsBoM7AaraoEwFZlbYAbFYtSUE8O5vukQzCrL/kdjWZ/ssp9OmszD/RkE
 k34GDxkfxo7fIm54T1RVcw7aiSiL+TcSSbAtaU/IPrC+luNTzU1c77DwUfKbgiS8ZtCm
 WP8kW/+WCiD0KjCaIXZnqSWJUqjJfUQJcbH4zHWqYVsLZy+kDGnXX0DzP3Kmdug5zwSD
 ikcQ==
X-Gm-Message-State: AOJu0Yzwt/b8boDGpHA/yTVqfJs8l3HCZyx+hqidvsw6UpfocZz+smg1
 JCc24OoNXUvETHJG2kFlebAeNXZqOG5xy7xuh3+QhH5thpU9JCRSpXvJ30g08JOKuFj8IpCIWl+
 0WulxUoXIRCfCvaHcu07t+veiQgIx82zVPlbm8r7H0Dc1GAdUKxRdqQxeXScW8gMPoXVIBCg163
 A+pjFn37TprB0W+wdzOMVCTGBgf8IdzDfwwZ8mgkOZ
X-Gm-Gg: ATEYQzyXQoC5+OggPYnbVtuzf1+7bKNh78ZVVfXZVYSxDGEAUaIx/o2K/IS4rRtUDzB
 lVJ4r9ATxRjpDtVcBHRHhVb9B20ylAPiwG1v0KhY6aOl3xvHQ9MJcRk6kkkoh2MLZaDNSfJ9Y+8
 lYuKIUsELQ1YqSv3uIo9bMIm/eajlDro+iY8DwVBh4xHBubGguFahyZ7cqHCJIHJfUWOHq2uB3F
 DRpMtqBlUSYXgqXR4yu5jtPmtAjNe/pS3dyj5+4VhfYwb2xC+jjamELS6Si+ZRi+VR3ab9QmQYQ
 2+m9N6j/3s/cGeCdZLj3I3o8aeub8OZllBfYKC/CvSGkEY5xEmOrqYTMap4eT00RB0uV0QpCwII
 qCdVBCDdKRzdnLobd+5jrjN6hU6V48G5xnRTuJl49XZBu63kSdJ6z4VTiU7AJBOUrLnKWd6QxrV
 7LuR75OWEnN55UcwaeUqy+PPfqkUA=
X-Received: by 2002:a05:600c:458b:b0:483:43da:6c87 with SMTP id
 5b1f17b1804b1-483c9bdb71amr195845405e9.33.1772441145458; 
 Mon, 02 Mar 2026 00:45:45 -0800 (PST)
X-Received: by 2002:a05:600c:458b:b0:483:43da:6c87 with SMTP id
 5b1f17b1804b1-483c9bdb71amr195844995e9.33.1772441144945; 
 Mon, 02 Mar 2026 00:45:44 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3addb3asm334398835e9.0.2026.03.02.00.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:45:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 047/102] accel/kvm: mark guest state as unprotected after vm
 file descriptor change
Date: Mon,  2 Mar 2026 09:42:42 +0100
Message-ID: <20260302084338.473368-48-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Ani Sinha <anisinha@redhat.com>

When the KVM VM file descriptor has changed and a new one created, the guest
state is no longer in protected state. Mark it as such.
The guest state becomes protected again when TDX and SEV-ES and SEV-SNP mark
it as such.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-7-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index cc5c42ce4de..096edb5e198 100644
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
2.53.0


