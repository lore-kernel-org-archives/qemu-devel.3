Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FACCC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 10:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA56u-0003DU-5Z; Wed, 30 Apr 2025 06:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA56o-0003Cy-R8
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:56:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA56m-0005nF-Dh
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746010565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=39kGfAjYMptZbUHBO5yxv8RjQYBz8uwo9OPKEFbLHGs=;
 b=XX5wP3brDbgB9cUHDNOlfawBpcA0oTBsLQTT+JMcEIE6mrEYKnmrc9uYSWTE16jdA5xgVz
 tM/TJ88m/SLqSUlqh1RDTO60Eo4Nd5sjnaXLrdxHA/bNM2okKdUkk7ije7xPhGpH3XFuO1
 gIYHfsMLRHF5mviTQGZmsmitCjLkrDk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-jEs8mI1wMHO8_KPgcX9TFg-1; Wed, 30 Apr 2025 06:56:04 -0400
X-MC-Unique: jEs8mI1wMHO8_KPgcX9TFg-1
X-Mimecast-MFC-AGG-ID: jEs8mI1wMHO8_KPgcX9TFg_1746010563
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ea256f039so52939715e9.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 03:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746010563; x=1746615363;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=39kGfAjYMptZbUHBO5yxv8RjQYBz8uwo9OPKEFbLHGs=;
 b=v7oOMM24Lq7fGo1nJ4eoQYA+GCxGvfT3dEq2Ex3lJQEqo61dkyEVEBWR3riBCqspII
 F8/RnegheUKhbX9zTLT47CHiyAzZG9revHnCKlOUmw4ulxjQj4kpwi9V/FECgLfIY2to
 UDDZVkVueZlVxvDW+CLXtincYiCG3P3J+3bkxpMq9+pLraGtOtp6exlP3ty6WX+gJKE3
 IYjpCXqT6+w3UAcbafjnW6puomVMsQMYayKz+Cap97D9fSot7rUGNyEoJhyWW3WsVCyH
 axZKKNNF+lVWRo5CkIEfHdgNSuPW5EImGcvVIzSUNXvv+jBzkhlShCmcPfawU3tt4PLC
 wYWQ==
X-Gm-Message-State: AOJu0Yw3SOdGVHCq+8CvEKsZANjFSkOQlQ++5ZYGRq/2SqErLkeTqpSr
 efqzOGQkXsXWGPx73G75vkIvXVIiOKd0qQheYSb+2c8jg7MQFO7ptJb7cBlKY51vRQt4c0L3n7x
 QTMl+PwkYsYmfIUvQN173VouW8SvZlCnzuG+Kva7OrRp2x4dXNIzF
X-Gm-Gg: ASbGncvPZVKrvhFi97rr/fNc8x0XRR+kQO9IGjQGq0Te/kBVkenD3V7pAsf2RGKYhTF
 bTtURcZE/NYkccBeQ8Vp9H279e0P6ifCu8mRzlj1YtCMCCcwwgWOKl4NOA72jydosUCzPTov2/e
 1pke163flPoL3bsMmIxAfpbK/ToPqj9myQf85J/+8trPjelw+V0czo7jFtP41685OP1t40ewr2F
 IxIiXCyzolHV2rr2cSVFzMGL6jRSqr6zr2CXcHxaZLNRtHkbQMzC3GwEjk0m/1Q+mWuTw93F7FK
 IMfoAe+GQN6vMMT5sTx9ZX1l6ibiUtBSiVgPbNQP
X-Received: by 2002:a05:600c:354a:b0:43c:fe15:41c9 with SMTP id
 5b1f17b1804b1-441b1f35c58mr21824255e9.9.1746010563314; 
 Wed, 30 Apr 2025 03:56:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHn9ETf++pq0y+kyhnBbwbT59OrMt36Wm41uEdILtMSNEKcewhM71OXPrRK7DNYaULEOuyjA==
X-Received: by 2002:a05:600c:354a:b0:43c:fe15:41c9 with SMTP id
 5b1f17b1804b1-441b1f35c58mr21824045e9.9.1746010562881; 
 Wed, 30 Apr 2025 03:56:02 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2bbf30bsm20076365e9.38.2025.04.30.03.56.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 03:56:01 -0700 (PDT)
Message-ID: <c747494d-fcff-48b4-b2e8-36bad8cc0431@redhat.com>
Date: Wed, 30 Apr 2025 12:55:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tests/vmstate-static-checker-data: Remove old dump
 files
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 John Snow <jsnow@redhat.com>
References: <20250429152141.294380-1-thuth@redhat.com>
 <20250429152141.294380-2-thuth@redhat.com> <aBFO7DcBWYpOp0-Y@x1.local>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aBFO7DcBWYpOp0-Y@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 30/04/2025 00.13, Peter Xu wrote:
> On Tue, Apr 29, 2025 at 05:21:38PM +0200, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> These files reference QEMU machine types that have already been
>> removed and thus are of no use anymore.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> I never noticed these files, but when looking it seems to me these two
> dumps are tailored to be used to test the script itself..
> 
> See:
> 
> $ git ls tests/vmstate-static-checker-data/
> e178113ff6 hw: Replace anti-social QOM type names
> 38ef86b5a6 tests: vmstate static checker: add size mismatch inside substructure
> af3713f6b9 tests: vmstate static checker: add substructure for usb-kbd for hid section
> c7173a9c18 tests: vmstate static checker: remove Subsections
> aa2a12bb82 tests: vmstate static checker: remove a subsection
> b5968f0ab3 tests: vmstate static checker: remove Description inside Fields
> ff29b8573f tests: vmstate static checker: remove Description
> 083bac3484 tests: vmstate static checker: remove Fields
> 1d681c712a tests: vmstate static checker: change description name
> fd52ffb9bf tests: vmstate static checker: remove last field in a struct
> 55e8e0e19c tests: vmstate static checker: remove a field
> ab99bdbe33 tests: vmstate static checker: remove a section
> 7daa3d76df tests: vmstate static checker: minimum_version_id check
> 4efa6e1d64 tests: vmstate static checker: version mismatch inside a Description
> a81d3fad87 tests: vmstate static checker: add version error in main section
> bc178dc563 tests: vmstate static checker: incompat machine types
> a10413e4fc tests: vmstate static checker: add dump1 and dump2 files
> 
> So dump2.json was deliberately modified to trigger all kinds of error that
> the python script can detect.

Oh, good point, I should have looked at the history, too! ... the files 
clearly lacked an explanation / script that is using them!

> Maybe we can still keep it there, but at least make it clearer that it's
> testing the script?  For example, we could create a bash under the same dir
> running the script over the two dumps and comparing the results to be the
> expected one?
> 
> Currently the output:
> 
> $ scripts/vmstate-static-checker.py -s ./tests/vmstate-static-checker-data/dump1.json -d ./tests/vmstate-static-checker-data/dump2.json
> Warning: checking incompatible machine types: "pc-i440fx-2.1", "pc-i440fx-2.2"
> Section "fw_cfg" does not exist in dest
> Section "fusbh200-ehci-usb" version error: 2 > 1
> Section "fusbh200-ehci-usb", Description "ehci-core": expected field "usbsts", got "usbsts_pending"; skipping rest
> Section "pci-serial-4x" Description "pci-serial-multi": Entry "Fields" missing
> Section "intel-hda-generic", Description "intel-hda", Field "pci": missing description
> Section "cfi.pflash01": Entry "Description" missing
> Section "megasas", Description "PCIDevice": expected field "irq_state", while dest has no further fields
> Section "PIIX3-xen" Description "PIIX3": minimum version error: 1 < 2
> Section "PIIX3-xen" Description "PIIX3": Entry "Subsections" missing
> Section "tpci200": Description "tpci200" missing, got "tpci2002" instead; skipping
> Section "sun-fdtwo" Description "fdc": version error: 2 > 1
> Section "sun-fdtwo", Description "fdrive": Subsection "fdrive/media_rate" not found
> Section "usb-kbd" Description "usb-kbd" Field "kbd.keycodes" size mismatch: 4 , 2
> 
> So the bash can make sure the result is exactly that.  If we want, we could
> even route that to CI, but I'd say optional.

I can include such a test in the functional python test, no need for a 
separate bash script here, I think. I'll try to include that in v2.

  Thomas


