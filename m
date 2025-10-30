Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F36ACCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 09:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEPBF-0007lo-04; Thu, 30 Oct 2025 05:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEPBA-0007l8-6z
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 05:42:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEPAy-0007fR-5O
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 05:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761817345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ssuTq9XFoKx8MU4gZ9j82/vZ6cbTNgdQccJy0+NTfjk=;
 b=UgGxIEC5LkIM048gxH6EZ1htbT7NROB7IBlycyX/vxjBDeb2r/G5MdyDLTL+aXjcKFyFE6
 geAp5Dr/d/tMhi5MVKD496bC+2fCSUQS+xuxrhRVmrJjoQ8iNOpfBBOdtfIA5C3sGabXUF
 mnZ+cuGIYS7KqPeMxnUhP+09As0DrP4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-vbvu6nuEPgy91Ovv3LX1Dg-1; Thu, 30 Oct 2025 05:42:23 -0400
X-MC-Unique: vbvu6nuEPgy91Ovv3LX1Dg-1
X-Mimecast-MFC-AGG-ID: vbvu6nuEPgy91Ovv3LX1Dg_1761817342
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4270a273b6eso1065236f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 02:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761817342; x=1762422142;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ssuTq9XFoKx8MU4gZ9j82/vZ6cbTNgdQccJy0+NTfjk=;
 b=VvXNmaayccX5w6JuEezXuKvRtxFPXD2j1dNrjT6zsV9jMaFKwziUQyz6smTTHE+YSz
 8pt+YBsucbYtLP5G+j+E1PUIsTyW84RGVxFDJjF2/4bsZBc8KmtoXSqmRX83kVphR0Oz
 IEdVHQmxZQdTsLbV/ys+phqLBk5p3AeWoSosHInrVsz9hCgczpAG1G/BpmS1jeYU/7ON
 1flRmyzThDzGxcKzhP9kN7NdMTIKnwQ8XArXduRUV75WE6R3L5VVeqOqx+i0s+9tgwbU
 C1nI0DRNkZGNO34raG7VBvh2jYqoFhk+qvLVKeMw4rAtoHA0OsPsifdj3nvW3ie+Pi6W
 sLXQ==
X-Gm-Message-State: AOJu0Yw8ewgnIu9Sdv4ky5VbxC5yrxZCRhDR1XUs+vB6IbGJtivDuns8
 d4jEQnYstipS5p2ovIlprU5G5IZUzS7hXf6gksWaf3h5vc4al6hgf/BW7+M6b75GdvicdOxQxfk
 qTa5tFdv4OcFVBitKKMqG1A3QPWTm2jT35/IdbNbzFIb8XpOaZfIWGtaV
X-Gm-Gg: ASbGncv5Gdg0Z9hgZbaPYfamO+bhdaDdZAcDcLGMbWjfDjJzDFc+4llaxykxOBE7ooU
 XA6GrPWG2lIEwunMlspmH5EZkJ3tQqAW5du5uDkGQmTtduFWMOlFoACkujIz0su2qvMqA1Go2Xq
 MeZmBjU+i1WI4VGGywQrZ8UrVgzGP8mXQiVAOd7p/oxG723yl0cAlbsh9f0aWNoUiSlt57bNCog
 ilCpqSmmWzoYfilPJvCODL6yIg+QKVsLnFNF0u5bMWCXM/NxwzK1xMmjyBbBS6Bky3c41RzIo4+
 I0Fz3M3ZXT7jmL4k0pmtc+j187jTF2VmMv3HLWBhRSwoFVcE2lQgOFoE8HLOVnwejjHJdno=
X-Received: by 2002:a05:6000:1acd:b0:3e5:394d:10bb with SMTP id
 ffacd0b85a97d-429aefbc029mr4724420f8f.41.1761817341943; 
 Thu, 30 Oct 2025 02:42:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6SkZQCBwQdmCl3xdqokXA+ODCHj0mt+FSbfk+PqWt2Cn1nedOODnCxnYaBGGgLALcubrmsA==
X-Received: by 2002:a05:6000:1acd:b0:3e5:394d:10bb with SMTP id
 ffacd0b85a97d-429aefbc029mr4724401f8f.41.1761817341475; 
 Thu, 30 Oct 2025 02:42:21 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d5678sm30484564f8f.22.2025.10.30.02.42.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 02:42:21 -0700 (PDT)
Message-ID: <7e315a0a-5876-4816-8db3-fecbe2b1ebaf@redhat.com>
Date: Thu, 30 Oct 2025 10:42:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/vmstate-static-checker: Fix deprecation warnings
 with latest argparse
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Amit Shah <amit@kernel.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20251030092638.39505-1-thuth@redhat.com>
 <aQMw-AO720PNFzWW@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aQMw-AO720PNFzWW@redhat.com>
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

On 30/10/2025 10.33, Daniel P. Berrangé wrote:
> On Thu, Oct 30, 2025 at 10:26:38AM +0100, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> The argparse.FileType() type has been deprecated in the latest argparse
>> version (e.g. the one from Fedora 43), now causing the test_bad_vmstate
>> functional test to fail since there are unexpected strings in the output.
>> Change the script to use pathlib.Path instead to fix the test_bad_vmstate
>> test and to be prepared for the future when the deprecated FileType gets
>> removed completely.
>>
>> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   scripts/vmstate-static-checker.py | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> AFAICT, using pathlib.Path should work going back to any old python
> versions we would need.

According to https://docs.python.org/3/library/pathlib.html it has been 
added with Python 3.4, and we require at least 3.9 nowadays, so yes, this 
should be fine.

>> @@ -393,10 +394,10 @@ def main():
>>                           help='reverse the direction')
>>       args = parser.parse_args()
>>   
>> -    src_data = json.load(args.src)
>> -    dest_data = json.load(args.dest)
>> -    args.src.close()
>> -    args.dest.close()
>> +    with open(args.src, 'r', encoding='utf-8') as src_fh:
>> +        src_data = json.load(src_fh)
>> +    with open(args.dest, 'r', encoding='utf-8') as dst_fh:
>> +        dest_data = json.load(dst_fh)
> 
> This could be
> 
>   src_data = json.load(args.src.read_text('utf-8'))
>   dest_data = json.load(args.dest.read_text('utf-8'))

Does not work, looks like the load() function cannot deal with a string:

$ scripts/vmstate-static-checker.py -s 
tests/data/vmstate-static-checker/dump1.json -d 
tests/data/vmstate-static-checker/dump2.json
Traceback (most recent call last):
   File "../scripts/vmstate-static-checker.py", line 439, in <module>
     sys.exit(main())
              ~~~~^^
   File "../scripts/vmstate-static-checker.py", line 397, in main
     src_data = json.load(args.src.read_text('utf-8'))
   File "/usr/lib64/python3.13/json/__init__.py", line 293, in load
     return loads(fp.read(),
                  ^^^^^^^
AttributeError: 'str' object has no attribute 'read'

  Thomas


