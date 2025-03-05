Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A263C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 17:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpsoT-0005eg-Id; Wed, 05 Mar 2025 12:45:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <momivolz@gmail.com>)
 id 1tprgj-00035m-JQ
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:33:41 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <momivolz@gmail.com>)
 id 1tprgh-0002rs-U9
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:33:41 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43bc4b1603fso23020235e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741192418; x=1741797218; darn=nongnu.org;
 h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=0mt8Svw7pqZ1y4z22Z/9HvJDbLgs1AV9GY+HXe3KyRo=;
 b=PqgUX/Dgr4d0gzXyo6MOHplwrr2qFa8TZB2OrM8N9C5qdJjMPE0SOGgehOTdapgxLz
 WzYiWA9AD79yuIjb9eArdqSNnXL+lyKytnPmG/iOcCN/zfM/IXxEU6eENGU21Y7ROFJK
 vxEqii03kNtDll1diyqjj2i9yX7YUb0/uIm0MGU8SCJdOkvwIM3W36o8i+OCB4+efLys
 AV5v/M8Cyxl6H6ZC2/I/AGQFDFn27mNFgxypY/jIqee98F+wJ88UpKab7XeeYHVJHKQ/
 sBQEYY6a+YQflEUlIXYJwglVoEXL39ATshisLGhBKD5Djsqy3zMz8gzZak+VecPs829i
 BI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741192418; x=1741797218;
 h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0mt8Svw7pqZ1y4z22Z/9HvJDbLgs1AV9GY+HXe3KyRo=;
 b=W7l0dPtZZUGWFQLwC5errzhWkADkhJJcTvg4nScF8W3/18tcowDC8RRU3DrLv0tWtp
 WP0suuIJXTa/iMpEHR9H9DYWuYkY/mxfB5lJYiqTLRy5iuT2JuLOmAZswOWwZF+eVTtE
 kpMaAPo8e+nBc9+lq/RGctL/OqgzAAR7UWiiJyFXtbb0tfI9o8EreVvOq6ReXDvWY1PR
 S2ciyYQHkky4RgbG/QHwJRMKNMiXS6uyz7clCteEP6l6toa6E/VEuBl+6ta5/CJORsRm
 xfTZGvdJIUzlNmhlzfycCNhp4NirzLmTjX9LGz/ItfHIlVQnrO88kfTF0yj7ieOWsDny
 ZcQw==
X-Gm-Message-State: AOJu0YwMf3j9JDrd0knVkavmvSl1SObEb4zq2xeU3WyMP0G+2FuSZYPV
 Y5WW672tRDcUZ9EVrMoCw+n55a7BVxs04K8r6LvyaebJlggKwEDV
X-Gm-Gg: ASbGncteI+3bfklwymcFJ20nMXYuiOukHWS5jLUqcYpikfocAcpoqf5D5aToIDb0drC
 YDCWl7XY80Qa4A3r8bsPHwrhtMKnkT4e/b4zrMeN6lZYd7KVsJ3r8lw+WPVjjCJgGHwIRY0DEnL
 8CI8CW2rwCi9R/apvlSojvxVxz8O5Vq2wyO/xZElZF1AG9UpRU8qhn1b9YuEyb42KaXGLh3yooh
 AKOXiSwgFwo6wQi2in9G+Sl28HBGCJf2rRW4gDA219K/upfICMW3aun5O4Z2DPzkjTD2WyxesN5
 M9saWQwhHFnRA382X4yVxZ8TD006Pwb4kmXNummSHRx55kW+JllGDxJLaT04evEvnTMy
X-Google-Smtp-Source: AGHT+IFfObi+H2akbJXgoZC/1gdAt8QenHp2LhGvVAeazEQPogRzd3szOTnRaAn1fUkrpVdw49/Alg==
X-Received: by 2002:a5d:6c64:0:b0:391:1218:d5ea with SMTP id
 ffacd0b85a97d-3911f75505emr4056337f8f.23.1741192416059; 
 Wed, 05 Mar 2025 08:33:36 -0800 (PST)
Received: from ?IPV6:2001:db8:11:1:c17a:2bf5:a230:8edd?
 ([2a01:599:304:ca55::1ea]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a7a2asm21696276f8f.37.2025.03.05.08.33.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 08:33:35 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------gc50ISQk0k5zG28bmnGPsspT"
Message-ID: <ab652f95-5cff-4bdf-b5dd-32f26553ba9b@gmail.com>
Date: Wed, 5 Mar 2025 17:33:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/main: Allow setting tb-size
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240730215532.1442-1-iii@linux.ibm.com>
From: Moritz Volz <momivolz@gmail.com>
In-Reply-To: <20240730215532.1442-1-iii@linux.ibm.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=momivolz@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 05 Mar 2025 12:45:42 -0500
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

This is a multi-part message in MIME format.
--------------gc50ISQk0k5zG28bmnGPsspT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.07.2024 23:54 Ilya Leoshkevich wrote:
> While qemu-system can set tb-size using -accel tcg,tb-size=n, there
> is no similar knob for qemu-user. Add one in a way similar to how
> one-insn-per-tb is already handled.
>
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   linux-user/main.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
Right now (commit 661c2e1a) it looks like this change never made it to 
linux-user/main.c in the master branch.

Interestingly enough the changes for bsd-user/main.c were merged in 
early November.

Did this patch just get lost, or is there a reason it was appied to 
bsd-user but not linux-user (despite the initial effort to maintain 
feature parity)? It looks like a useful feature to have and compiling 
from source for a 12 line patch is not very convenient.

--------------gc50ISQk0k5zG28bmnGPsspT
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 30.07.2024 23:54 Ilya Leoshkevich
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20240730215532.1442-1-iii@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">While qemu-system can set tb-size using -accel tcg,tb-size=n, there
is no similar knob for qemu-user. Add one in a way similar to how
one-insn-per-tb is already handled.

Signed-off-by: Ilya Leoshkevich <a class="moz-txt-link-rfc2396E" href="mailto:iii@linux.ibm.com">&lt;iii@linux.ibm.com&gt;</a>
---
 linux-user/main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)</pre>
    </blockquote>
    Right now (commit <span size="md"
      data-testid="last-commit-id-label"
class="gl-font-monospace dark:!gl-bg-strong gl-button btn btn-label btn-md"><span
        class="gl-button-text">661c2e1a</span></span><span
      class="fgColor-default">) i</span><span
    style="white-space: pre-wrap">t looks like this change never made it to linux-user/main.c in the master branch.</span><br>
    <p><span style="white-space: pre-wrap">Interestingly enough the changes for bsd-user/main.c were merged in early November.</span></p>
    <p><span style="white-space: pre-wrap">Did this patch just get lost, or is there a reason it was appied to bsd-user but not linux-user (despite the initial effort to maintain feature parity)? It looks like a useful feature to have and compiling from source for a 12 line patch is not very convenient.</span></p>
    <p><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------gc50ISQk0k5zG28bmnGPsspT--

