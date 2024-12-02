Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CBFD78316
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 12:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI5vC-00050A-9g; Mon, 02 Dec 2024 07:53:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI5v9-0004zl-6h
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 07:52:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI5v6-0004fE-GW
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 07:52:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733143974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HgonlbE6d9TF6j0R1tNUZiAPFRqbCHhphB/0Vk1DF6k=;
 b=VrPEkqvARodx7bUUnrGgyKkoQmjmAj5BBRlkWrOHNiPYdsONVLIi75dHjlVJm+RPtQn2Xu
 B8CnaLHwXUzXHk8jNnRdXTGKgwDoGGyQ8809r8H1QE7zy1qpPKJbKRdArnopsWOBoXmMBS
 umMx7juFvgQ6vrvjaRK9UGe4kXOT+mU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-Ma5ROlZlPKGUF1Vzs0NkkQ-1; Mon, 02 Dec 2024 07:52:50 -0500
X-MC-Unique: Ma5ROlZlPKGUF1Vzs0NkkQ-1
X-Mimecast-MFC-AGG-ID: Ma5ROlZlPKGUF1Vzs0NkkQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4349f32c9a6so34339775e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 04:52:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733143969; x=1733748769;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HgonlbE6d9TF6j0R1tNUZiAPFRqbCHhphB/0Vk1DF6k=;
 b=Fi5WCsmEc0qfmbvQznOVwZdOlo9kfrBnmvbzxgxNQPnBMrs6F4GbAYHcaUZlM2snnM
 gUeW+v0jjN3CiTdh2/O4mKsK6+93G1OKpMXBiDVFGu0lIuDtmf1hu43miltfR9S3r00I
 p8CT5qlG61Ve+dXUxeCVRIA3efhL1tcpFkHCzPZNeyo1VWjG+2tgIVFJLwFZpk9dSD/A
 Q0r5G0Z1POuecBexk1WigJVMy+0ILoKZ9Id/uTqb9fDVdaumvEBS1JwYsv5cUwE6rvOW
 N6bYJZXWiqgFJa1lbAcZ4UEcxISUDRRHOMg0PSOukU0S+Y6gFp7EaW9G03VeV4DO40Dn
 kJUQ==
X-Gm-Message-State: AOJu0Yx1Wpp2pJe73jezF45+3E9b59oR2baFAjCrsskBor27D84u1I0Y
 9YBjjo+YN5kI7KogS3yDoQl2ywpFJYsimI9f0Gyqjib6D72TE53VEavN6z/1H6jnNaBvpxtXNMD
 sN388el4LfQY3+zTHKSFRUp0TddDdGdw3i1epkHQrhXbB77uW+8aC
X-Gm-Gg: ASbGncvukJDHXu/7JjR86ZVi8amT1BhM1cux8gCUnAxrbAVZtb5ClfTXVmA9x3ELjxy
 TUUptoRyEebtIV2+fhHocyOcjGrnrmAq4QY1D5GGXGDCW/am9Wcoq+yTOq4ElVZ4A9oo7BVF7TI
 mfv1kslZPTqgUkLeVd5ofpDI5tKXVr6ocB9/BS5Py3MtHWG4vxakAPhVYsRW4SSVVmyxeXyjsJd
 ZGT3RJmDNriEp6XUJ0ZGKL8xwqguLOygPp1gta8zL1l6NZc0lyOVD/yMC4IsFLZThf4TRyTarY=
X-Received: by 2002:a05:600c:3b24:b0:434:a75b:5f59 with SMTP id
 5b1f17b1804b1-434a9dbb06cmr231440465e9.3.1733143968942; 
 Mon, 02 Dec 2024 04:52:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoD1yRRrAAudpAM1vza9yS26iBHNpFN6bJjVD7beKpQXLtfDqEuCN0ZzJiX+0JBaet4K1IIg==
X-Received: by 2002:a05:600c:3b24:b0:434:a75b:5f59 with SMTP id
 5b1f17b1804b1-434a9dbb06cmr231440175e9.3.1733143968562; 
 Mon, 02 Dec 2024 04:52:48 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0f70d9csm154614105e9.38.2024.12.02.04.52.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 04:52:47 -0800 (PST)
Message-ID: <808c81b0-c64a-4a32-9683-c96b51145da3@redhat.com>
Date: Mon, 2 Dec 2024 13:52:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/22] tests/functional: add 'archive_extract' to
 QemuBaseTest
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-19-berrange@redhat.com>
 <9277a627-13d6-4d0f-9802-dec6b2606cbe@redhat.com>
 <Z02kTzobRDeEYHQR@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z02kTzobRDeEYHQR@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 02/12/2024 13.13, Daniel P. Berrangé wrote:
> On Mon, Dec 02, 2024 at 11:30:28AM +0100, Thomas Huth wrote:
>> On 29/11/2024 18.31, Daniel P. Berrangé wrote:
>>> This helper wrappers utils.archive_extract, forcing the use of the
>>> scratch directory, to ensure any extracted files are cleaned at test
>>> termination. If a specific member is requested, then the path to the
>>> extracted file is also returned.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>    tests/functional/qemu_test/testcase.py | 36 ++++++++++++++++++++++++++
>>>    1 file changed, 36 insertions(+)
>>>
>>> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
>>> index 2f32742387..31d06f0172 100644
>>> --- a/tests/functional/qemu_test/testcase.py
>>> +++ b/tests/functional/qemu_test/testcase.py
>>> @@ -28,6 +28,8 @@
>>>    from .asset import Asset
>>>    from .cmd import run_cmd
>>>    from .config import BUILD_DIR
>>> +from .utils import (archive_extract as utils_archive_extract,
>>> +                    guess_archive_format)
>>>    class QemuBaseTest(unittest.TestCase):
>>> @@ -39,6 +41,40 @@ class QemuBaseTest(unittest.TestCase):
>>>        log = None
>>>        logdir = None
>>> +    '''
>>> +    @params archive: filename, Asset, or file-like object to extract
>>> +    @params sub_dir: optional sub-directory to extract into
>>> +    @params member: optional member file to limit extraction to
>>> +
>>> +    Extracts @archive into the scratch directory, or a
>>> +    directory beneath named by @sub_dir. All files are
>>> +    extracted unless @member specifies a limit.
>>> +
>>> +    If @member is non-None, returns the fully qualified
>>> +    path to @member
>>> +    '''
>>> +    def archive_extract(self, archive, format=None, sub_dir=None, member=None):
>>> +        if type(archive) == Asset:
>>> +            if format is None:
>>> +                format = guess_archive_format(archive.url)
>>> +            archive = archive.fetch()
>>> +        elif format is None:
>>> +            format = guess_archive_format(archive)
>>> +
>>> +        if member is not None:
>>> +            if os.path.isabs(member):
>>> +                member = os.path.relpath(member, '/')
>>> +
>>> +        if sub_dir is None:
>>> +            utils_archive_extract(archive, self.scratch_file(), format, member)
>>> +        else:
>>> +            utils_archive_extract(archive, self.scratch_file(sub_dir),
>>> +                                  format, member)
>>> +
>>> +        if member is not None:
>>> +            return self.scratch_file(member)
>>> +        return None
>>
>> Ah, ok, so the guessing is done here ...
>>
>> But somehow it feels wrong to have a "archive_extract" function in the
>> QemuBaseTest class that also does asset fetching under the hood.
>>
>> Could you maybe rather move this into the asset.py file and rename the
>> function to "fetch_and_extract()" to make it clearer what it does?
> 
> We can't move it into asset.py because not all callers are passing in an
> Asset object - there are some cases where we've just got a local file.
> eg when the asset we extracted contains other archives that need to be
> extracted.

Couldn't those spots rather use the function from utils.py directly for the 
second extraction?

Anyway, I guess now it's likely better to keep it here since you want to 
have access to self.scratch_file() in this function, too.
But maybe you could still at least rename it to fetch_and_extract() to make 
it more obvious what it all about?

  Thomas


> Per comments on the previous patch though, I could push this logic down
> into the lower method.
> 
> With regards,
> Daniel


