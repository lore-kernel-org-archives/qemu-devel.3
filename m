Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF0FC83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 11:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueXXd-0001Jw-E7; Wed, 23 Jul 2025 07:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ueXXb-0001HU-KL
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 07:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ueXXZ-0002RG-8A
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 07:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753269695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X1lA4RVpUjgBcsj+aeBSNMNXOP7zIQ3vZo+fiwCXxcA=;
 b=H3JiR9POGUoNqb095cAsBQkD5RsYQeDZBEd9+qAo9JulymF1ExYibxzzEJH++RkrMzwQdM
 N0V5Q7Sggqy9vRQp9NkuqoDry268nXOYeb0799KLZxt5n0Jyc17la/HqLtfuk0U2IllwWz
 8huuEz23prykd8NR0ZFRPSorIZ6aekc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-DelmGHCmOqel7D0najNlFg-1; Wed, 23 Jul 2025 07:21:34 -0400
X-MC-Unique: DelmGHCmOqel7D0najNlFg-1
X-Mimecast-MFC-AGG-ID: DelmGHCmOqel7D0najNlFg_1753269693
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-455f7b86aeeso33059305e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 04:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753269693; x=1753874493;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X1lA4RVpUjgBcsj+aeBSNMNXOP7zIQ3vZo+fiwCXxcA=;
 b=Q3tMM4Xtha6FwKiWYU6/jRdOAtTGtyggXzMLiY/VPtT6ZhXlTFGMSyQNi3a19fC6u0
 n80W95CsqMbJE+IF4mWuFWBy2GS0vdHay6Qz4mdoJgn//evw/Rx9QM95mMO6ELBK2GmF
 4hzmJFIQZWADZoYNDLSg9SxKVs5kpIgIBQ85dU45O5iPNAkY2wu5qOdHR9Fny3MUgdqI
 QoLk958fqJATgoToTgWPacc7vHhInofTYfDpFJ0LoW1FYrGOlpobXNhT0SDG9njlTmwg
 k5vjwO/m2g1vZsv78g2gCMGHH4JetI22qJIeg/ILhqsXtyBcuj/THs6VLi4Za+MSjxSB
 hnZQ==
X-Gm-Message-State: AOJu0Yz+Bi5FrCo3GBtRLL73gNnijp6NdFQsSKZYg1n5W3pd5GJxeA8O
 Iq7LWjVcHas02IvqaKZuGSETNVVbYIvRpdnF2f3PhKHhNuIexSTNYto8Q8dVRxwEJq3OjH3cfn/
 a1NvSr0on7EZ6YhL/zz5KmvFsudwdElVTK1onFp6/jSoonZEr0PtzLPsb
X-Gm-Gg: ASbGncvKskZ6MEWWh04KqcBF7dZ0HaQcUrG/ySmVuwlLBZwIm2ZLi4EYiGoNkQYRf7V
 FLK8g+fLvN6QpZAlT3mwYp7vJ6a7u6EUbdAQq4R+aIo7Wo3jmp0GjUGpb1hPqOvfnuHw6Y/LSVZ
 kUXmHqYlmEHN7LMhfl23dQVQj9vFWk282U7DrXr5ZpxjH4han6QcjpSaAqka0cWgWgeiotuTJWa
 lIz8tpfoKkP5zQnU/b4RCjXPqfOc/lR9ImCXH/NgM7hcudMk/ibNNwMJBE9vX80UZEQlCX3RyIg
 bL6YCjQwVE6pNXaODlV2C9wnLs9BNKzjv4KyHbVXR+rGtE2SIEpkj7TDJCkaMvwJJIkbxcBHlkl
 rEtAznWlUxNA=
X-Received: by 2002:a05:600c:4746:b0:456:d1c:ef38 with SMTP id
 5b1f17b1804b1-45868d65ee7mr18720285e9.24.1753269692814; 
 Wed, 23 Jul 2025 04:21:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzW2OS8kVW5nGxW6YUXuwdlK79F38P6OhxWgk4vapoS4g5JToJGA3aNiZ9UpRunMMQq6ZYdA==
X-Received: by 2002:a05:600c:4746:b0:456:d1c:ef38 with SMTP id
 5b1f17b1804b1-45868d65ee7mr18719985e9.24.1753269692366; 
 Wed, 23 Jul 2025 04:21:32 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4586918c6c4sm19960055e9.11.2025.07.23.04.21.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 04:21:31 -0700 (PDT)
Message-ID: <f215ad18-16b6-4232-a79d-b04d85ff3015@redhat.com>
Date: Wed, 23 Jul 2025 13:21:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 06/13] virtio-pci: implement support for extended
 features
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1752828082.git.pabeni@redhat.com>
 <253cd85bc76ded8259fc9d12ed3764e2507bcb75.1752828082.git.pabeni@redhat.com>
 <CACGkMEvBr0dQdNqtYNdOT+oN13aOWh1Hob7C6NLbSKCcEDPtLg@mail.gmail.com>
 <6a1e2b06-4f4f-45b7-8875-ecb60f74aa8d@redhat.com>
 <CACGkMEvoNZp=bsV_VtsxCE1zKMpS=DdXZQ+-aVcwtb5tibTckg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEvoNZp=bsV_VtsxCE1zKMpS=DdXZQ+-aVcwtb5tibTckg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/23/25 7:47 AM, Jason Wang wrote:
> On Tue, Jul 22, 2025 at 3:37 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 7/22/25 5:28 AM, Jason Wang wrote:
>>> On Fri, Jul 18, 2025 at 4:53 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>>>
>>>> Extend the features configuration space to 128 bits, and allow the
>>>> common read/write operation to access all of it.
>>>>
>>>> On migration, save the 128 bit version of the features only if the
>>>> upper bits are non zero. Relay reset to clear all the feature
>>>> space before load.
>>>>
>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>
>>> This is a guest noticeable behaviour change. I wonder if we need a
>>> command line option to enable and disable this feature for migration
>>> compatibility.
>>
>> This point is not clear to me, could you please elaborate a bit more? do
>> you mean we need i.e. a DEFINE_PROP_BOOL() or the like to enable the 128
>> bit space usage?
> 
> Yes, or maybe have a way to let the device to enable it automatically
> E.g when UDP GSO is enabled for virtio-net.

I think we can safely enable the extended space access (read/write) if
virtio_features_use_ex(vdev->host_features_ex). That should cover also
any eventual future addition of more extended features - even of
different devices.

/P


