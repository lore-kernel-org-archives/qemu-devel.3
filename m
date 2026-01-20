Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A77CD2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 08:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi74a-0002ha-GY; Tue, 20 Jan 2026 03:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vi74Y-0002Zk-N3
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:26:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vi74W-0003Uv-MM
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768897602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yaGCCcueMKOPfz8JDv9ii1KfyFVAImDuKJg8upyv8FA=;
 b=jQACRvkTUiMOBF6qadiJ9LfUryrPOrkNMsjPS8MZWr/O4ydazTXC8BfI9ZleUBUMi0FfY2
 ubeiRnJcIezXgpRRAMQ2OZ4ZkYwN0M/FtN3BzploxzTBVo1e4yvH+EWUvXpL+RP0jMJLHI
 1iOlJkzD4Oc7NYOz6dvOnGhmTg+ZmRA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-Z1yaQIBcNUSlLSWOTDkJfA-1; Tue, 20 Jan 2026 03:26:40 -0500
X-MC-Unique: Z1yaQIBcNUSlLSWOTDkJfA-1
X-Mimecast-MFC-AGG-ID: Z1yaQIBcNUSlLSWOTDkJfA_1768897599
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-431026b6252so5166701f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 00:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768897599; x=1769502399; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=yaGCCcueMKOPfz8JDv9ii1KfyFVAImDuKJg8upyv8FA=;
 b=EnAv2kIMu7dVbXG4jYf5h1DxoOBhgkhs2zo16OVAYRRU4K9GGAyfAwyvlARZ6DQNyw
 T/I8weiPaB6oyg1qjmR3ctylQhJWGIbeU9uh2w0xopSUJrym+WLZtMEQ15M/FcbhxbTX
 NsVKT18XawcGp9U6clER/Kt9eTLbe2ebLc4OcWvPYQGLOp7Q50FwJKoRlgVvDAOsyJaw
 AgmBG7DI0pevpgUyd0u+4Vdl2wj3jju1RVL0gKxxA6eS9+CngopJyza/R8kdHpw9yuax
 4waXaWDwoPUtHnQ2YOiT81qxZK6bkvL4YyRR39hU5VFFqKPNKB6lC6E0jX+mTCVSS1uV
 hT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768897599; x=1769502399;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yaGCCcueMKOPfz8JDv9ii1KfyFVAImDuKJg8upyv8FA=;
 b=re/EOE8zad7E6K+6Vxl7tu+EgP7Gvj3WWk3DiFLa/hMXVG+FP90qPKeGgJXeWUX2Ax
 XGCJn48xLtboAEE68L0suOsdVke6GwSIaucKa27CuTSu3WCK+ydfM6V6S3PQ1fr7M4G3
 qNYadbCUmZ6CKdklcyN1Ixka8E0K4xsh3Yhf2yLNsHbowQe8i8vuE70aaPwqw5BV610j
 g8Q8MR0K/Bxw0L2H6LWEOabqhSUfdcoGX720HZbQ7NyAGiu+BoI373UmT3e1kZlx1cAt
 4QLuyNLydhfba1C7ZWcZHT8w1khiRldXJyi6bTGgKt+nme7sjxssV8vwqym36GoIFA/P
 dm6w==
X-Gm-Message-State: AOJu0YyqsJI0r4Ykm4PukHd1oxDFLf0e9z82GNCAEfZQXniiwDmwncjV
 /4AWQuCpBxhSSdpUJ/fAHeXKMstcgr+6GWHVMSVhxeIzIKqgU7i8i6DZTQ8GVJPVqVrEQQ/ffwQ
 kQXWzoao0YAAfQfo7zye40sYgGurlojQivuXlNfd4ISNN1RHcA1lCvRO/
X-Gm-Gg: AZuq6aLLaXVhgUxmezryTqI7n/PhhDVbagqNnfS0XMmC7bnCYmx3nzdAhaK3pkmt/E6
 AUbP3S2o7qEbyHSonx8jkS4J9t7OudUnOQYvnaFnlpGR5kzG7LG9TJXH0rFkUJtAbSDvaTOJBZc
 L2646If4t9fnbDXautdFlGyvik1TWR2E0HnT9P+Khfa0dEyrHX2cod1MsY/WIELmxlf3mCyGnVq
 IdNSHZ06WeR0LEZQuDSZUfa0XDGlalKw1h1KFusvoahkgh5FBnPthEZictl0k75QRN9CYswq3UL
 N4RiNXTUFu3AHKvHuYZ3aTVfR7f5w4j06Wug0b4IvXAKHIBQMZAB7i752Ca1GLo7VMGwOtp2i7Z
 86m8EgQGfbv3mgc6w0g7nGdac8Xd1u/eU0hg=
X-Received: by 2002:a05:6000:2f88:b0:430:fdfc:7dd0 with SMTP id
 ffacd0b85a97d-4356a089943mr17532863f8f.63.1768897599011; 
 Tue, 20 Jan 2026 00:26:39 -0800 (PST)
X-Received: by 2002:a05:6000:2f88:b0:430:fdfc:7dd0 with SMTP id
 ffacd0b85a97d-4356a089943mr17532836f8f.63.1768897598470; 
 Tue, 20 Jan 2026 00:26:38 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435699271easm28165853f8f.14.2026.01.20.00.26.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 00:26:38 -0800 (PST)
Message-ID: <e9a55c88-9442-4462-9d7d-21b1d0196401@redhat.com>
Date: Tue, 20 Jan 2026 09:26:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] tests/functional: Add a OS level migration test
 for pseries
To: Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260109123519.28703-1-farosas@suse.de>
 <20260109123519.28703-3-farosas@suse.de>
 <CAE8KmOydo3r7x1AMWyO3hYEqrN5+XxHuz0y9OYNJc4nPMWq2DA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAE8KmOydo3r7x1AMWyO3hYEqrN5+XxHuz0y9OYNJc4nPMWq2DA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 20/01/2026 08.56, Prasad Pandit wrote:
> On Fri, 9 Jan 2026 at 18:06, Fabiano Rosas <farosas@suse.de> wrote:
>> There's currently no OS level test for ppc64le. Add one such test by
>> reusing the boot level tests that are already present.
>>
>> The test boots the source machine, waits for it to reach a mid-boot
>> message, migrates and checks that the destination has reached the
>> final boot message (VFS error due to no disk).
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   tests/functional/ppc64/test_migration.py | 12 ++++++++
>>   tests/functional/ppc64/test_pseries.py   | 35 ++++++++++++++++++++++++
>>   2 files changed, 47 insertions(+)
>>
>> diff --git a/tests/functional/ppc64/test_migration.py b/tests/functional/ppc64/test_migration.py
>> index 5dfdaaf709..a3b819680b 100755
>> --- a/tests/functional/ppc64/test_migration.py
>> +++ b/tests/functional/ppc64/test_migration.py
>> @@ -4,6 +4,7 @@
>>   #
>>   # ppc migration test
>>
>> +from qemu_test.ports import Ports
>>   from migration import MigrationTest
>>
>>
>> @@ -21,6 +22,17 @@ def test_migration_with_exec(self):
>>           self.set_machine('mac99')
>>           self.migration_with_exec()
>>
>> +    def do_migrate_ppc64_linux(self, source_vm, dest_vm):
>> +        with Ports() as ports:
>> +            port = ports.find_free_port()
>> +            if port is None:
>> +                self.skipTest('Failed to find a free port')
>> +            uri = 'tcp:localhost:%u' % port
> 
> * When port is None, shouldn't it return after the skipTest() call?
> With port = None, uri will become -> 'tcp:localhost:None' OR maybe
> port should have default value?

skipTest() aborts the test immediately, the remaining code after this 
statement is not executed anymore. (I think it internally raises an 
exception that is caught by the unittest code to mark the test as skipped, 
but you might better ask a Python wizard if you want to know the gory 
details. See 
https://docs.python.org/3/library/unittest.html#unittest-skipping for example)

  HTH,
   Thomas


