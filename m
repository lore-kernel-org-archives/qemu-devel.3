Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953F4D31A3B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 09:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfxXi-0000hK-OP; Wed, 14 Jan 2026 04:51:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfxXh-0000gR-3p
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 04:51:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfxXf-0001l8-I6
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 04:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768384313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HxycBi4to0MYGQgTToadlTXep5NYVSogDSNev3pE0YU=;
 b=bELK2Jrqrwr3BmxdKyj1gpG1tjf5fTTd4LRh9eyk+brvkihie1lwK8uWIN4NsYSHW9CzFn
 DLeibokicX96Q4ddHvXTf8qUkFHUiCvShIroXld6jToArzL6Bj0O/IFHxGMmJAbb+oXZse
 W8SfQ1aRkrWQMR3phsxkrL+lB7It/pk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-vgBZ0iwLNZ-pXVkD7GclPA-1; Wed, 14 Jan 2026 04:51:47 -0500
X-MC-Unique: vgBZ0iwLNZ-pXVkD7GclPA-1
X-Mimecast-MFC-AGG-ID: vgBZ0iwLNZ-pXVkD7GclPA_1768384306
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47ee71f0244so2093105e9.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 01:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768384306; x=1768989106; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HxycBi4to0MYGQgTToadlTXep5NYVSogDSNev3pE0YU=;
 b=LtnQq0iwWW7fNjACrsbDQyY5NID90TnwXJwprvjt1E5wsNX6P2xjzyWswgEApZs+mM
 yj9sd+vEWz5+wWXvgRf+eN46z7fwI4MdtXu9KqkCSx4lq+V/vBPqe/ggrJac93bMUiMN
 YKizCxxCZ7sHkCJKtJ9eXDqW+HkzA8KHauM9yYZGuMR/FzQuo/L5/B7f+B47Hj7j9Js6
 Add1lMGPu4bEVRJXfyYlxOVYBn8wmAXa1xXYXhv9dn0bN653PXEr7O0047LHKILMqOsi
 Ah0zIeP5o5zh516xAT0bhLcRV/skrKuhCSgZEDhHPlijt2u7Ieik1SGN0BOUsqTgjmE3
 rrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768384306; x=1768989106;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HxycBi4to0MYGQgTToadlTXep5NYVSogDSNev3pE0YU=;
 b=RVrn3/j97/4fl/Qr6+DTvCe3j643qq7EEMdt5wJ+EktrJeKLE9eoNYP5nl9PlWv9h0
 5vsUaHoiGkgXeJRF2vnYODCABz05ftAgRYQ/IcVLfz44ZhIabMto/pb4dQ+i9dIgVFMC
 SMwU3qC83qgh21UrI0xABn4GpYnBdIT0GAHAHGO+7VUocd6k5//F7TUX4aCUbi6juJbQ
 HX0xqXeCMrkHYwJevhq0LtAa92xHMdSX0FL0XTAwb0qHisgVSzVqUJX6uBY2COTETh6p
 ZnoK7Un7NAJQT7nSOb7/ZJg3bWi5uG1STGgK/FJov7DqsHVSQwqDajxiEy+9XQXqCtDw
 2vhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2DS0/Mwi3O1WR/BMwYUgyZUvjZcxAEoe9J/3MXpoKHEadk1koU0d/LaVmnLypxffJbxZgKG0zviCl@nongnu.org
X-Gm-Message-State: AOJu0Yzzb5sKMpOjrsLOxmME1FtunvCgu4kSiyZevCocZe25EQ4HPssL
 CRR2ok2AWhVVNczTzSI4pXwBJLCVu49qPbL54aArNj2zKsKQmjjhs+kOLW/xa9wwDMgXYtE64KZ
 d6hk7SWydaoQH25xUO5sUQ0ePTy0m6G1jXvsMNqdG4h4ceNlbRk88srw5
X-Gm-Gg: AY/fxX7WCE2s7iCuKS7mQ5VAtDdJhZX5nXqY9VJKoC21CHV0zoBpO4ZVHqZkL/c+Go7
 QExKuS+qe/IYmOYPbpHz0Di7iRAI8G5tAf889NhOGOOVrMf0F5CyGfbQJBRQxxOfq37537b2iNN
 l2MhlTXiEG4Ac7S37M9sjxEyhyTR7IZkPSk+2wpduyE6gucZrQyQHSpJ0oeAlQfaLCbgyR8voXg
 b4BbCOPi5UbDmjLuLOyNZBeGLuWGYPFMaGvMohdOwzlgD5BdZEKgZTxHb7w39NimjM1ReLnjw/T
 w02MZbQtTweHnCgqXEk0oTZKHZfXdlOaTKSSDdd5lUks17p6xO58xW0YZWOqRCNSmrO2wjesEkn
 rS2NLFEY=
X-Received: by 2002:a05:600c:638f:b0:479:3a86:dc1f with SMTP id
 5b1f17b1804b1-47ee4841b44mr11940475e9.37.1768384305748; 
 Wed, 14 Jan 2026 01:51:45 -0800 (PST)
X-Received: by 2002:a05:600c:638f:b0:479:3a86:dc1f with SMTP id
 5b1f17b1804b1-47ee4841b44mr11940295e9.37.1768384305370; 
 Wed, 14 Jan 2026 01:51:45 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee562d7aasm19433195e9.11.2026.01.14.01.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 01:51:44 -0800 (PST)
Message-ID: <c3f2f68c-9797-4a62-b1c2-3f2cd6333953@redhat.com>
Date: Wed, 14 Jan 2026 10:51:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tracetool: Honor the Python interpreter that
 "configure" detected
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>
References: <20260114092358.22961-1-thuth@redhat.com>
 <1945c9e4-b970-413e-a754-5b1b500b5758@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <1945c9e4-b970-413e-a754-5b1b500b5758@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 14/01/2026 10.29, Paolo Bonzini wrote:
> On 1/14/26 10:23, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> The tracetool tests currently fail if the host installation does not
>> have a "python3" binary (and you compiled QEMU by selecting a different
>> one during the "configure" step). This happens because tracetool-test.py
>> executes scripts/tracetool.py directly, so that this script is run via
>> its shebang line.
>> To fix the issue, pass the right Python interpreter to tracetool-test.py
>> via the PYTHON environment variable and use that to run the tracetool.py
>> script.
>>
>> -    args = [tracetool, f"--format={fmt}", f"--backends={backend}", "-- 
>> group=testsuite"]
>> +    python = os.environ.get("PYTHON", "python3")
>> +    args = [python, tracetool, f"--format={fmt}", f"--backends={backend}",
>> +            "--group=testsuite"]
>>       if fmt.find("stap") != -1:
>>           args += ["--binary=qemu", "--probe-prefix=qemu"]
> 
> What about just
> 
> diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracetool- 
> test.py
> index 30006a99190..efc518a6b1e 100755
> --- a/tests/tracetool/tracetool-test.py
> +++ b/tests/tracetool/tracetool-test.py
> @@ -36,7 +36,7 @@ def test_tracetool_one(tracetool, backend, fmt, src_dir, 
> build_dir):
>       actual_file = Path(build_dir, rel_filename)
>       expect_file = Path(src_dir, rel_filename)
> 
> -    args = [tracetool, f"--format={fmt}", f"--backends={backend}", "-- 
> group=testsuite"]
> +    args = [sys.executable, tracetool, f"--format={fmt}", f"-- 
> backends={backend}", "--group=testsuite"]
> 
>       if fmt.find("stap") != -1:
>           args += ["--binary=qemu", "--probe-prefix=qemu"]
> 
> (only the second half of the commit message needs changing).
> 
> Even if you keep using PYTHON, which makes sense, I would change the
> default to sys.executable.

Fine for me, too! ... Stefan, do you have any preferences?

  Thomas


