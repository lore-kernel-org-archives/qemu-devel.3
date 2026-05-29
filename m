Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7932CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 20:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3Xm-0000PM-QX; Fri, 29 May 2026 16:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wT3Xl-0000Ou-BW
 for qemu-devel@nongnu.org; Fri, 29 May 2026 16:10:57 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wT3Xj-0001bz-Sc
 for qemu-devel@nongnu.org; Fri, 29 May 2026 16:10:57 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490388fd0dbso86502745e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 13:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780085454; x=1780690254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2aU1YFIjTs+xi6z0HxVvyQdoK4mmvQH+XeNAiRA9cF4=;
 b=CKXMupfW+qazqPhX67SBA2hvP0KqTGHT6BMNZQpO8Dvg7byx3gzzvOndqErsxNHxjI
 bLQ1e63PR03vXpAQTuTs5F1F45XWUqZRFwKIbtzrOxqSlAVOQ6HPirpe86Y6gCyxkZKL
 /L0ulOWi/lv9pRYEn/n+DxrT9sbp6r+Oh34U8BP1byASwx8ezxEUtycl5+MewmYj38rr
 OYQZMTXMDR84z1iyXy1M+xcpmytkWaf7/hXuVdP3v3hWvWr7Adfn567QrNIe10kSVPI/
 w5zsKuwgeYvWVN4j2Rxv1uQkQi4WmTNQCTwv6Kci3GjTv9nZ1YUFo84JjBnvtrMe46VO
 8n5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780085454; x=1780690254;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2aU1YFIjTs+xi6z0HxVvyQdoK4mmvQH+XeNAiRA9cF4=;
 b=IJKMQyYYTOAkJDRvQ0A3w5TdRqFDayEba7shjR/kLsYySDftwGWhC20MpvhRWAGwyr
 PnErmLZo4affjZPzZU+O+As2pe2wq7txWAKefE5hv962qGOAOmKJUcsRuWwus45592Zc
 3qRogrRYD7mDxPnv4MyY+kcHFt7jrXqiNQgQsayv6n+N0cLqd3+iwt07c/5H67vb86qw
 TinNQ8JkC1X6l3dcjmysv3FZ3Zau0MPwdFNYHrPEvq71Kh+Fijw1xQxeB+ivEeQqzK4k
 F0X8MZOusglf6xIfN3PJCCuEVIveTfdQvdXKocNH9hqaLrE2Qoc6iCSjrUBaRGKVY44U
 1wqw==
X-Gm-Message-State: AOJu0Yye+2d8nEfplz/1uX44OGUhmFSgWNyQVZQWCTqtCKaq3X9NSD/G
 /pR/GQfHL5t443AIurtlNGvQ4AD6RlIYFTk9+e+0HSz3aB3Js6dTyyDg+vrJXsnkUzE=
X-Gm-Gg: Acq92OHNZFj38igohGKAZCVI3g5q4BJFGIAlqgU4vOe/afBDDSTjwyqO6z7ZrOtJVVw
 T3ii/Fs8vnFkn9m4NVlDpu/UQzlNlCX8lrqiGeXqkob+sOe9QEO4arcdm3C/lcPCa7Wm6Gflfcs
 f2MDaeM4v+wwENPcZjSlSkgLXBfAX5hTC4v6H5M1a2yw8Vdo7r2Y8FRIEfxfITya6JyS05VpKz1
 aILGcrPUGXcxjXeYo9MK3TXFB+l4LVdbauH/vEH7SDlSNH449whWlsp3M5+2iiAp0pW5LeeBHap
 Pt3PwLwOrERjcvjWaa2t+uWLgMDuhWqHjEN59ex7sQajfqgQKK1Us4NesfvaQ+rpEbztFsCz3vy
 LKXhhmo6OW1SNZNvOGRPwxlaEHDfVi+Jg7zMQe8g69aWkfxePsFoPYCz6WZyG/xfvRQ+AJkMxK0
 guVP9l1YWqeM+AJxrjEdELMgRjELGZE2of3A==
X-Received: by 2002:a05:600c:630f:b0:490:845d:652d with SMTP id
 5b1f17b1804b1-490a2948eedmr18799645e9.15.1780085453182; 
 Fri, 29 May 2026 13:10:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909ca6db64sm66438225e9.6.2026.05.29.13.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 13:10:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8BAD961D26;
 Fri, 29 May 2026 21:10:51 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] configure: use debian-all-test-cross for mipsel tcg tests
In-Reply-To: <cce86e0b-c685-4f23-873c-ca5499d8e442@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Fri, 29 May 2026 11:29:17 -0700")
References: <20260529181713.612230-1-alex.bennee@linaro.org>
 <cce86e0b-c685-4f23-873c-ca5499d8e442@oss.qualcomm.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Fri, 29 May 2026 21:10:51 +0100
Message-ID: <8733zaou2c.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 5/29/2026 11:17 AM, Alex Benn=C3=A9e wrote:
>> Although we have had the mips compilers in all-test-cross for a while
>> we had been surviving using the mipsel cross compiler image. However
>> when that was removed we missed updating the container to use.
>>=20
>> Fixes: 366bb88e785 (buildsys: Remove MIPS cross containers)
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  configure | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>
> Isn't that tested in our CI?
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

In CI the build is actually run in the debian-all-test-cross container
which is why it has minimal QEMU build requirements.

>
> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

