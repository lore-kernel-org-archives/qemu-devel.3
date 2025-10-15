Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D227CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 17:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95VC-0003ZI-Lg; Wed, 15 Oct 2025 13:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v95V9-0003WJ-AE
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:41:28 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v95V1-0001CH-Fj
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:41:27 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7811fa91774so5986096b3a.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 10:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760550074; x=1761154874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vwsJIirwXLXCJz81e1fZsYyuNQ/sijCuEumUF+Ei850=;
 b=Hsp5aChsqZpqM3+UWLmVqelhNNoJ1nGvy40xrpttSueN0L5mTNBnJb8h6AO5ZnxBqY
 TTCinvHrgheK7Lq8LzZ2S6dnp2TukN8g+ISDv1k50tfxAgax0KZgLXrBVtzgpo4W4d5U
 vmLCFZ/biAeR1ABybSIGqlKqxCSdbfZLtmrlc0BaLbpFSUEaCZ7agKUQY+SRMIoCWWUX
 v+9l0jdBxUgagfEIccWDaSMBY7LeqS3VkHTahzPgbqJDvIJ+V7yN7UTe+0UWeb80Meh1
 g3WMiBhiKoCGz0d8kMNjBLKb4pfIYXOqml2O+uZeaKjNvwT2RjighpIJqLyeo5p34sxC
 1dMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760550074; x=1761154874;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vwsJIirwXLXCJz81e1fZsYyuNQ/sijCuEumUF+Ei850=;
 b=ki80IvGDj7xrwawSAAktqB1/oWqDdaIL5zUkz+BEDyMp5AeHRqIfVrMBftmKof8FDj
 McUPaT79sGAwyf6HAxeC0fiNAdiPVkEcWtc5zICCjEoiqaY+9LzriRlLwao6x/w/ZPr4
 eXtu9QShBk5IEZ244ohDwGsIA+E5kAKi0U5zt/ga0FiKBH2yKI/R1+TgtgNSbBjIisVG
 fHow2bNAL/KZGJmTUUajnt1FopNDPc9mJbTuNGWpmHdjF609fPjnD32xnsIfGNEje0rc
 Xh9u2JB8Edo36DgphS/T9TE9rHe3w93YRKeSCGMNt/Qbsdfw8WI+/hTFyfijiPMjHe7J
 hGzg==
X-Gm-Message-State: AOJu0YwYp0ezPrrQLZdQsvXjLKV+gLhKibItPyEXQRdHgVnEmTMTt/EO
 8vx9u+Efp6YkNIzISBtWNQK6HlF7pP/AH6rE0TwMAwYR29DC6CcUSd1X96jdyS80+Cs=
X-Gm-Gg: ASbGnctt/8q8lHlFE1CMdZs9OEyvfEa6OIvEG0oi+DY1ywxk0FsEBqXaVf8EHXvTt3n
 bb69gJN3J9U+E/XrLnH1tCkjNkdNuoZ4ln+ykmTR1mgjhiZo7qdDV/JQ4DCeKygNqvRruJ8fn4c
 31GSeDG2TX436GDypybkYR8/wY/+GnSka07sbOQ3g75incboMEOpq49EfisxZpLnkELPt5sBhm+
 AVTv73xExCXw6gkli3yTDRa4iDFDtQpWgWdCgKSbuImVcL4RXZAEu9/2SPQnDjZRHZDhHqdzUdE
 E5RM4upcrFB4cqjklOHxiScR3UQYhhZP+odFMxBex7E2YrRB8x/8cFUOU8M1Vgh7C9DAMQ/xVbe
 yf94YWKcJrjBE3w7J3kWEeBUFRjHbFB7UG0eGSLrGazzeVsCUXD2US6Dac13WCpzypVd2
X-Google-Smtp-Source: AGHT+IFKoiCKwYfF4oBu2Xj1N/pEAbzbp7bKHc4dNqUTrbMxBMSGNbbjANG9APQE7aCyeF7TiLX+Yw==
X-Received: by 2002:a05:6a20:3d05:b0:334:879e:3c8f with SMTP id
 adf61e73a8af0-334879e3e5emr4361030637.25.1760550073938; 
 Wed, 15 Oct 2025 10:41:13 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a2288786bsm230892a12.5.2025.10.15.10.41.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 10:41:13 -0700 (PDT)
Message-ID: <4bea1c28-7c5e-4b5c-8757-21e5cb3545ab@linaro.org>
Date: Wed, 15 Oct 2025 10:41:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/uftrace_symbols.py: generate debug files
 to map symbols to source
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20251013213912.413386-1-pierrick.bouvier@linaro.org>
 <87h5w0ju6g.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87h5w0ju6g.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 10/15/25 4:11 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> Enhance uftrace_symbols.py to generate .dbg files, containing
>> source location for every symbol present in .sym file.
>> It allows to use uftrace {replay,dump} --srcline and show origin of
>> functions, connecting trace to original source code.
>>
>> It was first implemented with pyelftools DWARF parser, which was way
>> to slow (~minutes) to get locations for every symbol in the linux
>> kernel. Thus, we use addr2line instead, which runs in seconds.
>>
>> As well, there were some bugs with latest pyelftools release,
>> requiring to run master version, which is not installable with pip.
>> Thus, since we now require binutils (addr2line), we can ditch pyelftools
>> based implementation and simply rely on nm to get symbols information,
>> which is faster and better.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Queued to maintainer/oct-2025, thanks.
> 

Thanks Alex.

