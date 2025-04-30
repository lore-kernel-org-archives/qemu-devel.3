Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2662C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 11:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA5O5-0001UQ-Hh; Wed, 30 Apr 2025 07:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA5O3-0001TA-Bc
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 07:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA5O1-00088i-8G
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 07:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746011634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GusUV+t4jIpf/nDzHULR+DMC8F0jpNPmYK6Sr8d1luo=;
 b=cDR0Q+67mEifFQXDPRS12SClWoDh7jlZYzmOGYjnA7oHtrTSwZLXFjtLyKFFGRUSgpyv1A
 7wPFkHt1rXy5ff/iDtEtgMWOjzKiet9HuKfMVATXfPKnoBYhGYs1E+YrA7Ez0UpfjhSKz9
 PN0Z4k1CvKg1bq5oT/1NxTzcRm4tiPE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-cXigi8pRP9KXNRF3c2VyWA-1; Wed, 30 Apr 2025 07:13:51 -0400
X-MC-Unique: cXigi8pRP9KXNRF3c2VyWA-1
X-Mimecast-MFC-AGG-ID: cXigi8pRP9KXNRF3c2VyWA_1746011630
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43947a0919aso49103875e9.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 04:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746011630; x=1746616430;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GusUV+t4jIpf/nDzHULR+DMC8F0jpNPmYK6Sr8d1luo=;
 b=QZ3mNEgsTuTOuQZdHqpBGh75M0NrUlcD+MkmXPz1TnxJtw3VHkHpsQObdhliTGvQai
 r5YbazqvrzRD0vTcy+rpixLkeR0RKhg5jkeWSw7Jn0d3YIcQz8nj3HdVV1E9uZmLyklF
 3TKOU7saedWppPFTI8ZhNoPbdSDyr3OnMtbTitPju1R3aaMuUNIDpjh/BHKMjkyZebVS
 zcPLzSeuHRFgE7BUwQAqYQfJYX976FhM7/ITgv4ULVs1W+IiD1u3cGbJ3ej2mBubscsC
 dc8Fs8EeuYtpkwx82LgUcw3NXk8LQ3DvnQqaNC2vtup7BWruNDltlk4Hoe4RjdmAYHCB
 yuOg==
X-Gm-Message-State: AOJu0YzXjT5LaGJ9UP1Qk+lvHOtDpdMahi8c4yTF0bQRIYQTjtVdhA2Z
 fvwcnb/YP+LnHUC3g/NNUOGVH1jynJ0TyxwRn0aoNMuBpkGmoDRhRmUEGTwKOlus+yQS4sAc4Hw
 Uo8IJ8nrwlAeBlenyOTHnK1pqf2Zg/4bhQ9MiBfP7MBztAl5HoXIh
X-Gm-Gg: ASbGncvCICgRNzDK+ECwz88Ce26Qx9YtYEJWYPMLuMt7XV4JRzqXgOQ83V1/bZF1TXn
 OccstLnAq690SFiSwwE26VPIqhtBTN8MURbDGyCyOKQuXTAR0rudvaj1A+MX4Xt6apojHflEpGH
 sQiCamDylcc78VpqnBzEVy0l1t4DRfMU0yhgfz/osGdSFKv/5JG0QItPbwoslvlwsHKjE3YOrCL
 GLKmBastu4rEgHTUMkATB1sKaz6weUtALUP6e05c5E7xFpFXkMp5vD+mBhippq68awowmyomHfA
 HQTtwSEYa7SmVRfe+vqjal8JdW1106SBDzubFecQ
X-Received: by 2002:a05:600c:384a:b0:43c:ec28:d31b with SMTP id
 5b1f17b1804b1-441b263a413mr23086585e9.10.1746011630257; 
 Wed, 30 Apr 2025 04:13:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqpHv6jqcOwe7UyiN3VGOc4SMHlg72RuQ6VeuRTJIh8vg57AfIWBhi8zhe0ymfrrXHFV2NvA==
X-Received: by 2002:a05:600c:384a:b0:43c:ec28:d31b with SMTP id
 5b1f17b1804b1-441b263a413mr23086265e9.10.1746011629840; 
 Wed, 30 Apr 2025 04:13:49 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2bbc613sm21296105e9.31.2025.04.30.04.13.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 04:13:49 -0700 (PDT)
Message-ID: <d5585d6b-fc61-4127-9acb-6235271fc45a@redhat.com>
Date: Wed, 30 Apr 2025 13:13:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tests/data/vmstate-static-checker: Add dump files
 from QEMU 7.2.17
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 John Snow <jsnow@redhat.com>
References: <20250429152141.294380-1-thuth@redhat.com>
 <20250429152141.294380-4-thuth@redhat.com> <aBFTE8r3lyqUcAsT@x1.local>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aBFTE8r3lyqUcAsT@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 30/04/2025 00.30, Peter Xu wrote:
> On Tue, Apr 29, 2025 at 05:21:40PM +0200, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> For automatic tests, we need reference files from older QEMU versions.
>> QEMU 7.2 is a long term stable release, so it's a good candidate for
>> checking whether the migration could still work correctly. Let's add the
>> files from that version that have been taken with the "-dump-vmstate"
>> parameter of QEMU (compiled with single machines and the configure switch
>> "--without-default-devices" to keep the json files reasonable small).
>>
>> Some devices also have been removed manually from the json files, e.g.
>> the "pci-bridge" (which can be disabled in later QEMU versions via Kconfig),
>> and some Linux-related devices like "scsi-block" and "scsi-generic" and
>> KVM-related devices. Without removing them, we might get errors otherwise
>> if these devices have not been compiled into the destination QEMU build.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   MAINTAINERS                                   |    1 +
>>   .../aarch64/virt-7.2.json                     | 2571 +++++++++++++
>>   .../vmstate-static-checker/m68k/virt-7.2.json | 2936 ++++++++++++++
>>   .../ppc64/pseries-7.2.json                    | 1068 ++++++
>>   .../s390x/s390-ccw-virtio-7.2.json            |  475 +++
>>   .../x86_64/pc-q35-7.2.json                    | 3402 +++++++++++++++++
>>   6 files changed, 10453 insertions(+)
>>   create mode 100644 tests/data/vmstate-static-checker/aarch64/virt-7.2.json
>>   create mode 100644 tests/data/vmstate-static-checker/m68k/virt-7.2.json
>>   create mode 100644 tests/data/vmstate-static-checker/ppc64/pseries-7.2.json
>>   create mode 100644 tests/data/vmstate-static-checker/s390x/s390-ccw-virtio-7.2.json
>>   create mode 100644 tests/data/vmstate-static-checker/x86_64/pc-q35-7.2.json
> 
> This looks like an improvement indeed, it so far only covers machine type
> 7.2, rather than all machine types.  I used to run these by hands before
> each release.. and sometimes I forgot.  Before me, I am aware at least Dave
> used to run also during softfreezes.

Since I had to strip down the dump files quite a bit (compiling QEMU with 
--without-default-devices etc.) to avoid errors when the current build is 
limited, it's maybe best if you continue checking manually at least once 
during the soft-freeze with a non-stripped json file.

> One thing I am wondering is if we can do it the same way as the compat
> migration test in CI, so that we always compare with a base (which is the
> previous release binary), then move the base after each release.
> 
> After all, due to migration-compat-common CI job, we always build the base
> version of QEMU already in build-previous-qemu, so we already have two
> binaries at hand.  IIUC we only need one new job to generate the two JSON
> blobs, and feed them to the checker on both directions.
> 
> If that is the case, it might have a benefit that we can cover all the
> machines as long as listed on both binaries, then check all of them?
> 
> Meanwhile, if we keep the ball rolling for each release (by boosting the
> base QEMU binary version), IIUC it guarantees all the new binaries will
> make sure to provide compatible VMSDs all across since we start running the
> job.
> 
> Would that work?

I can have a try, though we might need to teach the checker script some more 
things first, e.g. it's getting confused if we clean up old and unnecessary 
fields like in commit 445d3facffe82788b880107c0849dab9505b33d9 ...

  Thomas


