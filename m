Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC6FD58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyyS-00043O-Eh; Mon, 02 Mar 2026 03:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxZ-0003SQ-0T
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxX-0002HO-8u
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yDTch7d+9uggTBZ+m5g1YxQiJY/J0MiJKjInBlOgjdI=;
 b=E6iSm6Q9yxpF7Q20HMHXRcCMM9r+iBCLnvCEIpg41ykRk7G+a89YHJBfYtWNgZ9Qf6Pr7r
 BvwZgqa8tU3FNEXedcbcgSjhnU8FoJwJ7pGB/uGUC+i6R06lT0+xcx9BQA3uf8zz4CqviA
 24io86TtQKZnh45CJB8ZNkkHqTbEgXE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-rUfQlft7OzC0Nwgf20SgKw-1; Mon, 02 Mar 2026 03:48:57 -0500
X-MC-Unique: rUfQlft7OzC0Nwgf20SgKw-1
X-Mimecast-MFC-AGG-ID: rUfQlft7OzC0Nwgf20SgKw_1772441336
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439b8858b0cso392530f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441335; x=1773046135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yDTch7d+9uggTBZ+m5g1YxQiJY/J0MiJKjInBlOgjdI=;
 b=PGhqFKg9E6/npUTJkgq2PE8dwmklBkWgfJkcGk+brGITncrQxuIZXZ2RXdECS3I701
 rXexfh6bOGPRBDFM82DQwT73E062v5ZiDMeYQt5eq/GOEHLNdaDrp7p9jP74D2QGyZb/
 zY0v4nHd/DMwVvnDY+UoUicXlmxSoGEmOH+jShYIrfj62luXhm78HbmwzubPm8S8lomu
 ALrC26K8SJTJDSdtfjbpu/Zbyj0rd5f9fmw1ZXL4i9h8J7ag5Cb+p7oIt03ZG6745HW9
 01GbNm654Y1fzu8wGeUSaol7OaPN018x5IW6L5Xta+pnfi67vXN2yGgGHXp1xcwEa8Dl
 XaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441335; x=1773046135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yDTch7d+9uggTBZ+m5g1YxQiJY/J0MiJKjInBlOgjdI=;
 b=ptNN8803d0vu9vulSbQ2ZDGGDAQGFwHkKm3WhfQ9nIXSKhe25xIfk/rV3z+ELD6Wnr
 7Z/Fb9UgJq78wkTOP28IEXRWFi/67k1oIT4Afoxv4C6Ef1uJhTNOr1VPRn2E2Exo2Rf1
 eTuyC3uRXTPk+kQ+5w3LM0MQkQg4P3dHgsDYnaQkd63tDV0CPf3CjBUsDVqU6T7v4wz3
 2qfNtvbq61lkLqbWiXQ3oQw2+/Jf7aBoOaGZtqzMNLXN3W0ZfgvGJ5FJamd8RpCR2GvY
 ZaqDcMxdkBDKfw0Bzb6KAqhQxVUT5YSF9PGBEnnJYsgZv/BIydWB9IvSICGjD7ATeP0W
 zR5w==
X-Gm-Message-State: AOJu0YwqKruCJtThxGpHCgE0YRmoua7Cgd2zPExzWN8u0y/duru6KKhY
 8SQGH3tj/eFyU1ba2pNsQdGjh+2WqfnPywiWC5Q8EzQu8MHhL7mmpiIXTpdOlzqUMJvbLNhtj9i
 iDzX3SFmFYaMB14YiJssIm6esyeB6IPgH8phbmNoqovHjzMTC/ce9qczlyjcTtB2nI4GEDRuvC5
 iUB7AsdQIYrlJLl9z+vVwyCU1wjNkAMTv6UUGQPsMi
X-Gm-Gg: ATEYQzzN2D6D0YQcNzP2/7K2VfFwHuCEZvpbbaDTxwgA1BU+djw63GMcolCiajpillO
 mekuxvHLZLobNgEz9cXCpuBqIWj7QPpzuNWODfU3yG0Upb53OR4RGzVU/aMYnBqg2RaJ3wzUOyt
 p1hmi1ylKnA8d/g2zt0+QyHdeSfpzyz9isz/nLXjz3cIqDMSqpsCapNW+mNV+H3NpSRUcQBAV+Z
 lj1fLoce+rAZXwYeEE8hOn20zFf5LAnuHAEvoaqcuxz1J/cSITiXQfAM0BMFtxqkVfLCrqyxQn8
 Bg03OHisUzK6fN1cbvfUXc2Wd/FQabbKbyYNRLg6+4tRir+4iLCmn/VIiqx/g/JbwE/2A2UROVS
 Xzb/U3+4CjS2rMSBTRnNG2x780iTYIOjZBMN7jEbG3b3SA1kqPYaJFu76REc7dpjqX73K9LZ/+B
 /wJj4YgMtTxQte96QpPK1dNhJus+I=
X-Received: by 2002:a05:6000:4282:b0:439:ba57:5010 with SMTP id
 ffacd0b85a97d-439ba5750e2mr2196416f8f.39.1772441335253; 
 Mon, 02 Mar 2026 00:48:55 -0800 (PST)
X-Received: by 2002:a05:6000:4282:b0:439:ba57:5010 with SMTP id
 ffacd0b85a97d-439ba5750e2mr2196368f8f.39.1772441334747; 
 Mon, 02 Mar 2026 00:48:54 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b3cc2e65sm9963582f8f.2.2026.03.02.00.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:48:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Jon Kohler <jon@nutanix.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PULL 092/102] target/i386: introduce GraniteRapids-v5 to expose
 ITS_NO
Date: Mon,  2 Mar 2026 09:47:38 +0100
Message-ID: <20260302084749.474955-26-pbonzini@redhat.com>
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

From: Jon Kohler <jon@nutanix.com>

Expose ITS_NO by default, as users using Granite Rapids and higher
CPU models would not be able to live migrate to lower CPU hosts due to
missing features. In that case, they would not be vulnerable to ITS.

its-no was originally added on [1], but needs to be exposed on the
individual CPU models for the guests to see by default.

[1] 74978391b2da ("target/i386: Make ITS_NO available to guests")

Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Link: https://lore.kernel.org/r/20251106174626.49930-4-jon@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 81779483d31..987f64c5af3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5443,6 +5443,15 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 5,
+                .note = "with cet-ss, cet-ibt, its-no",
+                .cache_info = &xeon_gnr_cache_info,
+                .props = (PropValue[]) {
+                    { "its-no", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ },
         },
     },
-- 
2.53.0


