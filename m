Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA83C54EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 05:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtJJc-0006Qt-4a; Fri, 20 Feb 2026 00:44:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vtJJa-0006QO-2l
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 00:44:34 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vtJJY-0000aj-4H
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 00:44:33 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-824b05d2786so1282963b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 21:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1771566270; x=1772171070; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a4YHU0XZukIdkaB/6iJ/4AiC+/8jwkyQRbZDXIKeAx4=;
 b=TH5qYrfw0LrjQ1w3Qz4FWrOdFqaz0AYOLEj7uWHYsBmjr8XFDy9Zgd4GXjCB50SBLb
 ZNEmfK3/Ul4QedCwkaOE99/0trIW0agnxlXqNjtvnKPYvsDnSnTUaSkjDIfDRIOZOocE
 EJK8dcu/N4iTl7JPgP5AzMUgqxbsvwYEkH+WyyaLN4jH1SvQCBtaNA8EKM2O8ViqcCiy
 9NT8fKqKR+VO59xjcVtphodnDeD+FtQOA/6aQ1VM0qAllgDhP3+DGRF4HBVoCcpDzHW4
 GtXS4GRUzDNkHwbZaI1e8v5behgB5GBxq+PnUQVyUlCb30hhI2Q7HU3fq/phj8ZVDLqA
 k3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771566270; x=1772171070;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a4YHU0XZukIdkaB/6iJ/4AiC+/8jwkyQRbZDXIKeAx4=;
 b=InUFKZ1AbzP205s0GDuUcWaVWaZRKaucHMd/6x2vkmYDJKha4ECZqIY4lXekMFLqwu
 eH4rTNJc1Iy1R3z4OUGG8UWorwOxZeX2oj/mNHFYVCPSMvXlncwkXu0y+FhqBX6Ok2uX
 A+0kQios0NaABA5WoiBEwsIdAEngKXPJkPZ/jAUOk9lqoyOMYu+BxD7X6LpXtXwmjvRV
 7/BtKQ79Zo6l+XxV72ciRTP+to/PlLxReBLE12LL2TcOi1Vf5wqoR+0XlX1fYTa49h6h
 bgUeZtDkQwRTmsm+ScDVxpRQAfqk0SJ3V2nDmENHMkBqCE/NZHV8Jh56iNrmFjg8zag8
 DLzA==
X-Gm-Message-State: AOJu0Yy7fr2zy/2E1zqfOLlvT5jQXck2IkFF+S26/S9WgeqPnQjtbaTQ
 ocNbnB8H0z9+atRbI/7NJok0bWC5UCjwy9QgEAgAex+rz/mzbjC0NG7gWwRbZZ01HkE=
X-Gm-Gg: AZuq6aJIVc7W+3qIUFwuGE5H2FHizT9MPSQb5QXaqVAMXNsHvBY5NHqkdinyhgU2GxB
 PM8MuzlGzPo+oVML1SHnzg5nS6pLDI3UsfmfjUJCWS+sH++vaEy79C6TjJbYrW+layWV/peKsGJ
 tuQU0i6jo9tSl8FfylszcCFyFKRPJ3lU5/clCZumkOhiUJ2WAuq8QhzGBh2fsWbtXmgwvB18U2Q
 lCHlFJlyY1BjNhCZlFoSdBo+HTZe21lJGjIoNKKPPPnH5/bsJXmxTfc0VgvbRhQh3M69JnsxBVn
 GNux2rpVdlo97qxmPJBv9PVSOuz391MwRyj+VGhPjTrC+JTYnfjxH9daExWS0NHhq+iyGMTmKhj
 BJg2cUocH+CcgMsrlToKAFPih0G428SABekAUm/xdEa+69m4PnaeMNZ+LnkPUtxFIeahrcqHoh/
 Up1yV4dAyZ8HxK049+TT3DlEYnf3t4Irusau4CcqfHkSVYbVWPydt9H8QSty5otcXXCBC3MAchp
 6Y=
X-Received: by 2002:a05:6a00:1ad4:b0:824:a635:4181 with SMTP id
 d2e1a72fcca58-825274c5bdcmr7672924b3a.15.1771566270340; 
 Thu, 19 Feb 2026 21:44:30 -0800 (PST)
Received: from sifive.com ([136.226.240.194]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6b6a099sm26098970b3a.33.2026.02.19.21.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:44:29 -0800 (PST)
Date: Fri, 20 Feb 2026 13:44:27 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 8/9] fpu: Add conversion routines for OCP FP8 E4M3
Message-ID: <aZfli2koayS41FRS@sifive.com>
References: <20260205111622.461497-1-richard.henderson@linaro.org>
 <20260205111622.461497-9-richard.henderson@linaro.org>
 <aZKVxean7S9fkHHn@sifive.com>
 <695ae1da-8ca6-4966-87fa-5cd712cda59a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <695ae1da-8ca6-4966-87fa-5cd712cda59a@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026-02-16 15:30, Richard Henderson wrote:
> It doesn't feel right doing this here, because true overflow is handled
> elsewhere.  This is re-packing a FloatParts for a given FloatFmt.
> 
> Perhaps parts64_float_to_float() would be the proper place for this, as
> that's the conversion operation, and recognizing this overflow feels like
> part of a conversion.

Hmm, I agree with you. Maybe we could add a new float_to_e5m2 similar to
float_to_ahp and replacing the parts_float_to_float calls in
float32_to_float8_e5m2/bfloat16_to_float8_e5m2.

+static void parts_float_to_e5m2(FloatParts64 *a, float_status *s,
+                                bool saturate)
+{
+    switch (a->cls) {
+    case float_class_snan:
+    case float_class_qnan:
+        parts_return_nan(a, s);
+        break;
+    case float_class_inf:
+        if (saturate) {
+            float_raise(float_flag_invalid, s);
+            a->cls = float_class_normal;
+            a->exp = float8_e5m2_params.exp_max - 1;
+            a->frac = MAKE_64BIT_MASK(float8_e5m2_params.frac_shift,
+                                      float8_e5m2_params.frac_size + 1);
+        }
+        break;
+    case float_class_denormal:
+        float_raise(float_flag_input_denormal_used, s);
+        break;
+    case float_class_normal:
+    case float_class_zero:
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}

Thanks for the feedbacks,
rnax

