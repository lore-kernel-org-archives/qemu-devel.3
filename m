Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DB9CA0EEA
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 07:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjwDW-0002bo-Jj; Fri, 30 Aug 2024 03:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sjwDT-0002TX-Fr
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 03:38:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sjwDE-00046B-0n
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 03:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725003507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eiubQgvhrzuQWPgoBM6FrxLvx0Q7plA9DVDLXOxnfxk=;
 b=Se66eHUY9n89+mdbxYgTnjCzRc3/XeVjd4R9NMS7oIb0Rm4kSmKkC8TMgrEQgI+WrtBAz2
 83FtZBF45V+b93eQG7uwnheye7Kn78osKmIuEcEfatOjYXE3vqjt1DhRF4qH9jowa6Yz9C
 8yD0xkNUXNQU1qHVcPqC2l1TPO4wqsE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-L475Xvl8OCKVYMGhS-iu3w-1; Fri, 30 Aug 2024 03:38:25 -0400
X-MC-Unique: L475Xvl8OCKVYMGhS-iu3w-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-454e94467ceso21439051cf.1
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 00:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725003504; x=1725608304;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eiubQgvhrzuQWPgoBM6FrxLvx0Q7plA9DVDLXOxnfxk=;
 b=FSF5gQwA/TS6iie9BDGIa5bnQGLadW8pOb8CVVw/sXOhVRrKREPPOod6VEnhBQVIbe
 e+q7BjMXHoq1rKApvGSngTYbCi8pAFf7eYS6xF3EENS7SsW2BLWssX1A7NQ5v+jf80M9
 XOELNKXWxQmPBFk1rJxiGEe6tommO3E5BCEEKO+nRIdwo+AilUfdX668cYQ3Jc1+u+nP
 CHAH9Km07D+6MhhCgdEI1M8vxTeQPNTNUI9K1fPKUMgA0+mpTIuUkxOikCr6AJQYxtCn
 tWvnxajreRdWlnWDzd2A8kfR8qNP6QVsUrfQ7Iv3uKRQfEsVx9HgRcaQR8zp86JdQDUB
 BmXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAfyEbivUXqzmsvZKQOigpo5H4nsxRRn+NEY8N24Lk9BYag7/wHDQF/lojdoJqheUR6MubMrLK6lTP@nongnu.org
X-Gm-Message-State: AOJu0YyZDuX4qLBQ/wFJ4FA4reuwHV2Or87V5RLRozMQoAihZOsZq0xa
 CAocuj4g+GW1yql4nBlu7hKz6EKafYLmFTU9EJGnVwkyGufjqb8UkCjmAI8GAYlZXzg7xle4VrN
 GTYMw43HXbFVDNvjZdsx6lVmB/jkje0o5d6lVw5zxL6bklA9CVakt
X-Received: by 2002:a05:622a:1c08:b0:446:3c7a:3689 with SMTP id
 d75a77b69052e-4567f6b3dddmr50016671cf.43.1725003504382; 
 Fri, 30 Aug 2024 00:38:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyo3YamxYkQbVV5KMnugcTWSnPhcaPB4t7YXe5S1y2/udg22TqS8N/J9VesQ1FN3bD3ULUlA==
X-Received: by 2002:a05:622a:1c08:b0:446:3c7a:3689 with SMTP id
 d75a77b69052e-4567f6b3dddmr50016571cf.43.1725003504000; 
 Fri, 30 Aug 2024 00:38:24 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-179-35.web.vodafone.de.
 [109.43.179.35]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45682c98067sm11810521cf.22.2024.08.30.00.38.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Aug 2024 00:38:23 -0700 (PDT)
Message-ID: <c6d6f31d-d507-437f-9f7e-7857ed415fea@redhat.com>
Date: Fri, 30 Aug 2024 09:38:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/35] tests/functional: enable pre-emptive caching of
 assets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-16-thuth@redhat.com>
 <3a435391-f485-4223-93aa-b937a141db16@linaro.org>
 <2e2c6480-8a43-4606-b500-2e60bf583d00@redhat.com>
 <f126030e-faf9-429e-957d-db503f7e5e33@redhat.com>
 <ZtBKR205LUm9qvgu@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZtBKR205LUm9qvgu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 29/08/2024 12.15, Daniel P. Berrangé wrote:
> On Tue, Aug 27, 2024 at 04:24:59PM +0200, Thomas Huth wrote:
>> On 27/08/2024 15.16, Thomas Huth wrote:
>>> On 23/08/2024 09.28, Philippe Mathieu-Daudé wrote:
>>>> Hi,
>>>>
>>>> On 21/8/24 10:27, Thomas Huth wrote:
>>>>> From: Daniel P. Berrangé <berrange@redhat.com>
>>>>>
>>>>> Many tests need to access assets stored on remote sites. We don't want
>>>>> to download these during test execution when run by meson, since this
>>>>> risks hitting test timeouts when data transfers are slow.
>>>>>
>>>>> Add support for pre-emptive caching of assets by setting the env var
>>>>> QEMU_TEST_PRECACHE to point to a timestamp file. When this is set,
>>>>> instead of running the test, the assets will be downloaded and saved
>>>>> to the cache, then the timestamp file created.
...
>>>>
>>>> When using multiple jobs (-jN) I'm observing some hangs,
>>>> apparently multiple threads trying to download the same file.
>>>> The files are eventually downloaded successfully but it takes
>>>> longer. Should we acquire some exclusive lock somewhere?
>>>
>>> I haven't seen that yet ... what did you exactly run? "make
>>> check-functional -jN" ? Or "make check-functional-<target> -jN" ?
>>
>> After applying some of your patches, I think I've run now into this problem,
>> too: It's because test_aarch64_sbsaref.py and test_aarch64_virt.py try to
>> download the same asset in parallel (alpine-standard-3.17.2-aarch64.iso).
>>
>> Daniel, any ideas how to fix this in the Asset code?
> 
> So when downloading we open a file with a ".download" suffix, write to
> that, and then rename it to the final filename.
> 
> If we have concurrent usage, both will open the same file and try to
> write to it. Assuming both are downloading the same content we would
> probably "get lucky" and have a consistent file at the end, but clearly
> it is bad to rely on luck.
> 
> The lame option is to use NamedTemporaryFile for the teporary file.
> This ensures both processes will write to different temp files, and
> the final rename is atomic. This guarantees safety, but still has
> the double download penalty.
> 
> The serious option is to use fcntl.lockf(..., fcntl.LOCK_EX) on the
> temp file. If we can't acquire the lock then just immediately close
> the temp file (don't delete it) and assume another thread is going to
> finish its download.
> 
> On windows  we'll need msvcrt.locking(..., msvcrt.LK_WLCK, ...)
> instead of fcntl.

While looking for portable solutions, I noticed that newer versions
of Python have a "x" mode for creating files only if they do not
exist yet. So I think something like this could be a solution:

@@ -71,17 +72,26 @@ def fetch(self):
          tmp_cache_file = self.cache_file.with_suffix(".download")
  
          try:
-            resp = urllib.request.urlopen(self.url)
+            with tmp_cache_file.open("xb") as dst:
+                with urllib.request.urlopen(self.url) as resp:
+                    copyfileobj(resp, dst)
+        except FileExistsError:
+            # Another thread already seems to download this asset,
+            # so wait until it is done
+            self.log.debug("%s already exists, waiting for other thread to finish...",
+                           tmp_cache_file)
+            i = 0
+            while i < 600 and os.path.exists(tmp_cache_file):
+                sleep(1)
+                i += 1
+            if os.path.exists(self.cache_file):
+                return str(self.cache_file)
+            raise
          except Exception as e:
              self.log.error("Unable to download %s: %s", self.url, e)
-            raise
-
-        try:
-            with tmp_cache_file.open("wb+") as dst:
-                copyfileobj(resp, dst)
-        except:
              tmp_cache_file.unlink()
              raise
+
          try:
              # Set these just for informational purposes
              os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",

What do you think, does it look reasonable?

  Thomas


