Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092CBF9936B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrKj-00010k-Vq; Thu, 23 Apr 2026 06:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJZ-0000XM-Mh
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:29:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJW-0005Ji-Uq
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9a3hhCSXfvl6hrvS8EB9HmHH4pMxsfQNH+Ao/VJt6go=;
 b=GyMc9ZoxUe8s9jl4mO2hiY9PoTQMy7hvVL9lhzOyH1Vd6P5oNOwOOoOXNa/PoQy/28+tD1
 QxLQ80Ow3xALUuVxeiFU2r/JSaizYeBW6XWKMriVqdCnjgrk8kliTEztqiros1pfsNCjPP
 D4Yp3VF+acLRWoeRsZsTxonXk8Y+/i8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-kScmvEiMOIalq9zcPfK6hA-1; Thu, 23 Apr 2026 06:29:41 -0400
X-MC-Unique: kScmvEiMOIalq9zcPfK6hA-1
X-Mimecast-MFC-AGG-ID: kScmvEiMOIalq9zcPfK6hA_1776940180
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48a5adc12ffso12879285e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940179; x=1777544979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9a3hhCSXfvl6hrvS8EB9HmHH4pMxsfQNH+Ao/VJt6go=;
 b=K/LxdhGwTuM3wm9gPkL9Nv9XYFlx6GoCevy1seu+YO+LGOpxj35rubG0v6JNgC4Rd/
 1b0Bt4yTd2foEF9DrCw4uV9fELnnANV3ivttneAxBl0Fwa8DP+F9rsjFYvAcKg11ZBDu
 FFOm6leAvY97CuHOCDI844ET8t+XOWcHmUs4j1Hnfc9Jr2LYxs/gPJa97FTLgJvzf7KL
 NbFdAKmC71R50QCxb1jWelvlmElujyW2G7/UXyq96QPXQCRDgchm8433I+6XOzsu8Qas
 FvBpRbb8xQpV50y7wzVyxJOGY0JLXPlzZyiKWLHMZDdaRhIiOCFbhjtE74Tdj+JHb/2F
 UU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940179; x=1777544979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9a3hhCSXfvl6hrvS8EB9HmHH4pMxsfQNH+Ao/VJt6go=;
 b=TvD13ilWEPqKkyWUDa3K39RpnPrKV3y2pDXF1QInq/fHxjdJWAv/9RmHqqDU14yf8T
 mCGUQ0Wqz+2i1AGDHVJ8p1SnYzoC8hqSX+4AiMzUWXT6mdAtsOta3pJvOFSWFYQFIB93
 n13rBZ1Qc8Wrs7MJLdZ12p8PMOJaWlVWP8e1PxxaxOGwYzu3n3WEjGDFkkoO+GBveM92
 O8Wgy7z1vyo42H7dQ6TiFnajdFx7qvZL3A5rvEXLmlVyQVtGQm0w/f2xK2VmBvfY0lHh
 rP8siODuI61Fmk7hnEiwjRENLaWzGBtg6jUbIfxGEGybz+22oOnVevdzeoDfj6oTxXZY
 NjDw==
X-Gm-Message-State: AOJu0YzSkmWhcM00IMPyUyJHeLZWUFBJHUZVxor9hAUnswuMefj1CVrc
 6WhOsB9CQJ5hg0+OojO0ZFdkQaPt00H2NdMUe3mIFyEI51tzSdbh7yDFVSVHv3ST0QA3PCpwyaA
 vdMOY2TBz2co/DlLsu6eHcW3fwAkV76uQ3tU5MTT8UB6teNKGSDYoDrcJgDLxrUnRdsdO3fOhCH
 5DUikXpv6a0OVWag7SGtWBflOVXz5gK7zyQvPVV2IF
X-Gm-Gg: AeBDievk/N6jPOTRhhc+CKXjWVpeM0nMBMJLbKixb3WamRt2aC2x+bTwJXPe7YSin57
 tA/31IpxC/rO0MaIp0PEnYfc38tQt3cXfuUFjp4C7YxrdtWVFglh5+FyUFFEuUnoH+/oftGMPw2
 RnZG0t+i6rXgUhHB4A7T1a6++KuEsn/bd/RnKeb2KxMbBrTngoVZmNmQaAglbUm8xGhwOX239Mu
 w6nictTZyphEdS+Ua0kHsFRftUVMi64jX35OhaHzOAmL634ov+4sPHnRMqWy3RItfiYW2sWaa0e
 lguGf7Q3HNDMmK0M2ImfhpnbsTwFILiX2VpnKqWi/JdzhEA7JoiC6lfga2IIX7oWGnYo00/yoyc
 rWuwXNU/0JOyqy6TSexbwJmsM+nTGOhFbMQ3/P4gjqbTa0a9NfjmSn4UMDZyxhUAUF1hmjbAh26
 dTlJXBcNElFNyC6msKSu9OgC3zzyTZaRCvJIw=
X-Received: by 2002:a05:600c:6209:b0:48a:592c:e63d with SMTP id
 5b1f17b1804b1-48a592ce89emr114081385e9.14.1776940178951; 
 Thu, 23 Apr 2026 03:29:38 -0700 (PDT)
X-Received: by 2002:a05:600c:6209:b0:48a:592c:e63d with SMTP id
 5b1f17b1804b1-48a592ce89emr114080905e9.14.1776940178347; 
 Thu, 23 Apr 2026 03:29:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7aa593sm160874585e9.24.2026.04.23.03.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:29:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/25] block: Use glib2 instead of strcasecmp/strncasecmp
Date: Thu, 23 Apr 2026 12:29:03 +0200
Message-ID: <20260423102922.443639-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kostiantyn Kostiuk <kkostiuk@redhat.com>

This is a change in semantics. g_ascii_strcasecmp() doesn't honour
locale but strcasecmp() does. But this is OK for at least one reason:
 (1) QEMU always runs with the C locale so there's not an actual
     behaviour change here
 (2) we want the comparison on url prefix and it should be a plain ASCII
     one, not to do weird things with "I" in Turkish locales,
     so g_ascii_strcasecmp() is better as it's explicit about that

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20260327134401.270186-4-kkostiuk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/curl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 419df78258b..684c677ef71 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -871,8 +871,8 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
         goto out;
     }
 
-    if ((!strncasecmp(s->url, "http://", strlen("http://"))
-        || !strncasecmp(s->url, "https://", strlen("https://")))
+    if ((!g_ascii_strncasecmp(s->url, "http://", strlen("http://"))
+        || !g_ascii_strncasecmp(s->url, "https://", strlen("https://")))
         && !s->accept_range) {
         pstrcpy(state->errmsg, CURL_ERROR_SIZE,
                 "Server does not support 'range' (byte ranges).");
-- 
2.53.0


