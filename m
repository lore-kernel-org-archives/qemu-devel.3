Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FA2CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4NTh-0007ob-P8; Thu, 02 Oct 2025 13:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v4NTd-0007nS-P2
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:52:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v4NTS-0000XL-A0
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759427524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=foEpRowZ01PqTKvoM2xThhJ8MmKeG842BlGMmgn/k4c=;
 b=Vp0qV3crqZRUs5uEkrcDBsnTh9vkmKgq4WlyXmfaz7trvfA/kvVWCR4vY0KqHBXxCV3IFh
 0A/D1BNzZChJhyN4S77PNQMNq9mmS73ze6+r7GOtXZrVfUa9sCadKKV8QXzz55cnnudvvj
 Rqz00t5Y96xQ8HRdQT8NbAX7D+62m4A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-LriXOzG_OFiAH7i1TvCCyg-1; Thu, 02 Oct 2025 13:52:03 -0400
X-MC-Unique: LriXOzG_OFiAH7i1TvCCyg-1
X-Mimecast-MFC-AGG-ID: LriXOzG_OFiAH7i1TvCCyg_1759427522
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-40cfb98eddbso1227355f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759427522; x=1760032322;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=foEpRowZ01PqTKvoM2xThhJ8MmKeG842BlGMmgn/k4c=;
 b=AfiEEfU7mPDNjvYSCdeTo0/xEiqGoCH88SQG4so6hYNyZ+3aMyYaW9E63v819f5+I2
 6u7VIVqymCZ55zblWjXvO7CJ8W4vEhMMCakRM14tv6C2SwMek2MM3t77Qox2yZJynRKg
 dpNEdbLy/otrVaPz1xcuYAfr8Y7fpnPP3BD98ytJU7weK7Mkn+egDMSxNwuAq0PBxNG0
 E4oLF7RnIX69Ld3rr8SQ/gnkwSsuKy7AimbJ1dyytL2VBOthZkETImpcsbeyCOSW1EdR
 odK5Je/exzHLimRw2FOtquHJz0J1aX+gMTPd0PmaH1iusMWydMBGU/UA5fM9e7jot28/
 w9rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeMk+sCp+wLnMiYi2ShymLvrCwOWMz4ZnXQVx3ZqBkd+AkquKFCYUEzhAs9iiyXYZ2sk6ECWvEyAFt@nongnu.org
X-Gm-Message-State: AOJu0YxvLk78CBPg31I7sA7zwS1/hBsehQ4g0AFp065QU4C1pTj1pFSY
 +ydevqRmQYbtTmgRCx3fgUA/NeybDHQo28AKHolr/Ur1TKLzUwgehF2LsuCcc1ih9XNGx+1V7hV
 fx0Elx6uFD3v34zys+dXUnc0Osom0gam7v8iBIdfveaaK2YX4S5h1W3d6
X-Gm-Gg: ASbGnctYMuDXDELvvji4W9YKFU/KymD0TamFwbEuZTFQajKqqSlrj+eneDQ/NhlVkOU
 Bqtbj2DUICR94qnwsSWXK9I436+mY/lt/FxdrgxqABXCqGYLuz0oDMNPmyO4wbwNkoAgLugH+la
 IaeCie9r1YqqxNb9s50bI8yUsGRQd9aS+5t6n/kxw/64p2ZLASX7qo2mNlETak5GUQiuI6weBsF
 AIQiz13OjTboHKUHL58R0jF/3Us9YcoZshI6GZxlVhm5+J89UjozJYsCBQIWCLPAy50ynOTnPPa
 B7qNLT5ZlQPI0AWeCE35IQ3fyfi/kR4xHvNj7piYsioAez45MWK8dG3yxCHKfVfBEifo5oQ8DqW
 1MsQWExQJ7g==
X-Received: by 2002:a05:600c:1d05:b0:46e:477a:f3e3 with SMTP id
 5b1f17b1804b1-46e70cb75c3mr2139595e9.18.1759427522134; 
 Thu, 02 Oct 2025 10:52:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETa7VcbZV1dy4v3P42ErfHfC0GoB0wdHq7sh3UMSAvVXCKD71ZwKIjqKqUMoye5kN0vUrBzg==
X-Received: by 2002:a05:600c:1d05:b0:46e:477a:f3e3 with SMTP id
 5b1f17b1804b1-46e70cb75c3mr2139435e9.18.1759427521719; 
 Thu, 02 Oct 2025 10:52:01 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e693bcc93sm44043815e9.13.2025.10.02.10.52.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 10:52:01 -0700 (PDT)
Message-ID: <8fb3351e-f1a1-4a1e-9650-33f0d4ee6d44@redhat.com>
Date: Thu, 2 Oct 2025 19:52:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
From: Thomas Huth <thuth@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org
References: <20251002020432.54443-1-gustavo.romero@linaro.org>
 <b5cb30d8-65a2-4bf7-b66f-5bfe61e19835@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <b5cb30d8-65a2-4bf7-b66f-5bfe61e19835@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 02/10/2025 18.53, Thomas Huth wrote:
> On 02/10/2025 04.04, Gustavo Romero wrote:
>> The goal of this series is to remove Avocado as a dependency for running
>> the reverse_debugging functional test.
>>
>> After several rounds of discussions about v1 and v2, and experiments
>> done by Daniel and Thomas (thanks for all the experiments and comments
>> so far), I've taken a new approach and moved away from using a runner
>> for GDB. The changes, I believe, are much simpler now.
> 
>   Hi Gustavo,
> 
> unfortunately, this still seems to be broken on Fedora. After applying your 
> series, I get:
> 
> stderr:
> Traceback (most recent call last):
>    File "/home/thuth/devel/qemu/tests/functional/reverse_debugging.py", line 
> 100, in reverse_debugging
>      self.reverse_debugging_run(vm, port, gdb_arch, last_icount)
>      ~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    File "/usr/lib64/python3.13/unittest/case.py", line 156, in skip_wrapper
>      raise SkipTest(reason)
> unittest.case.SkipTest: Missing env var(s): QEMU_TEST_GDB

Looks like it's required to explicitly use the --gdb=... parameter of 
configure to make it work, and it does not work without that paramter? Could 
you please have a look whether it works without --gdb with the auto-detected 
gdb for you?

  Thomas


