Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111EFC27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEU6U-0003QM-4I; Tue, 04 Jun 2024 09:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sEU6R-0003JK-Od
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:21:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sEU6P-0000g4-Hy
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717507283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VUFkDpI/gwfzcyvDoSy+Njf0KodHXbbPoSukJUmVlO8=;
 b=cJUajgCGt6i90JVO5fhaF2HnOvAzHMAVD9At1Fv1m3w4+3Q1z7FTYybfB4EtRns4WWpzsg
 YUozas7u8iLKZbiMXizxtaw8VngJqj6fVKuo/rfMh/HZwSMeEOaAu0CJwCAlo4YonTvF3C
 jjDB/cxbmuPiFQhUuDrOOdLQq/Jt5BM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-LpOOJ1ziNku4sbmLjdmUZw-1; Tue, 04 Jun 2024 09:21:21 -0400
X-MC-Unique: LpOOJ1ziNku4sbmLjdmUZw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52b93441828so2107378e87.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 06:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717507280; x=1718112080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUFkDpI/gwfzcyvDoSy+Njf0KodHXbbPoSukJUmVlO8=;
 b=h/QsUUkDipzql3HMdlMOJu/+OVx+QRLtOZLtYIx0JtUsm8NHdKLeAWZ/YCTloFcVrX
 ewdb7zLaHo7sPDFWL5vOX6bd7wGENwWp++dLg0ESujJQF0ZfGbmri+s4wFcnv12FHwdZ
 jNLxD3zlwrIaQ18Yo/W/rXpAJWEnn0U03bnlzeIFBWQwCv3Q2957u6NSMTdrUL4QdMDl
 V15wKxLuTHIuUebuCtWK8jW29Dt9pch27ZTUSG7nz1LNsyGHDaIZhJrZ6iyRHdv4zweJ
 i36/9vndMBOquYBDoGi711N15cossSRziOlN6EN5FMyv3vlRWArV9sDEJ/p5oqKfs5Gu
 iuyw==
X-Gm-Message-State: AOJu0Yy9QVZQ8wgNENQ+kO8yLrgVAZTqqPs4Ij4KAu1AhlWikEDeQmVv
 VL0YnRHvsQaveTyrWLtuM9OPprSdb+it7i2HWIsoHG33XuXcsPLtzH8+xOhRGV94UaLAe7F3WiB
 +VMC+7LAq4tKYNtU1pUtVnlxlWbksZCyB2SHiZBC2/QMBd23IlLST
X-Received: by 2002:a05:6512:45b:b0:523:8a79:21b with SMTP id
 2adb3069b0e04-52b89560a68mr8718237e87.11.1717507280354; 
 Tue, 04 Jun 2024 06:21:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0l2ildw0grj2M2dMJfKCd/LLVYBCql87YrXDIRQkFG1p+6uz/+p3MeyqWVKKhh4Oz/OGucQ==
X-Received: by 2002:a05:6512:45b:b0:523:8a79:21b with SMTP id
 2adb3069b0e04-52b89560a68mr8718223e87.11.1717507279888; 
 Tue, 04 Jun 2024 06:21:19 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-171.retail.telecomitalia.it.
 [82.53.134.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd062ecd3sm11762763f8f.74.2024.06.04.06.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 06:21:19 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:21:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] qapi: clarify that the default is backend dependent
Message-ID: <a5rtqdvsqevk2pobqipmfiv5eazr5koffe3tn372i7bojpshhg@q7uxoverycvu>
References: <20240523133302.103858-1-sgarzare@redhat.com>
 <877cf61ib1.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <877cf61ib1.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 03, 2024 at 11:34:10AM GMT, Markus Armbruster wrote:
>Stefano Garzarella <sgarzare@redhat.com> writes:
>
>> The default value of the @share option of the @MemoryBackendProperties
>> eally depends on the backend type, so let's document it explicitly and
>> add the default value where it was missing.
>>
>> Cc: David Hildenbrand <david@redhat.com>
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> I followed how we document @share in memfd and epc, but I don't like it
>> very much, I just can't think of a better way, so if you have a suggestion
>> I can change them in all of them.
>>
>> Thanks,
>> Stefano
>> ---
>>  qapi/qom.json | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 38dde6d785..8463bd32a2 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -600,7 +600,7 @@
>   ##
>   # @MemoryBackendProperties:
>   #
>   # Properties for objects of classes derived from memory-backend.
>   #
>
>[...]
>
>>  #     preallocation threads (default: none) (since 7.2)
>>  #
>>  # @share: if false, the memory is private to QEMU; if true, it is
>> -#     shared (default: false)
>> +#     shared (default depends on the backend type)
>
>Note for later: the backends are the branches of ObjectOptions that use
>MemoryBackendProperties as branch type or as base of their branch type.
>These are
>
>    memory-backend-epc (uses MemoryBackendEpcProperties)
>    memory-backend-file (uses MemoryBackendFileProperties)
>    memory-backend-memfd (uses MemoryBackendMemfdProperties)
>    memory-backend-ram (uses MemoryBackendProperties)
>
>>  #
>>  # @reserve: if true, reserve swap space (or huge pages) if applicable
>>  #     (default: true) (since 6.1)
>> @@ -639,6 +639,8 @@
>>  #
>>  # Properties for memory-backend-file objects.
>>  #
>> +# The @share boolean option is false by default with file.
>> +#
>>  # @align: the base address alignment when QEMU mmap(2)s @mem-path.
>>  #     Some backend stores specified by @mem-path require an alignment
>>  #     different than the default one used by QEMU, e.g. the device DAX
>
>As stated in the commit message, this matches existing documentation in
>memory-backend-epc
>
>   # The @share boolean option is true by default with epc
>
>and memory-backend-memfd
>
>   # The @share boolean option is true by default with memfd.
>
>I think "with FOO" could be clearer.  Perhaps something like "with
>backend 'memory-backend-FOO'.

Ack, I'll do.

>
>However, even with your patch, we're still missing memory-backend-ram.
>I can see two solutions:
>
>1. Create MemoryBackendRamProperties just to have a place for
>documenting @share's default.
>
>2. Document @share's default right where it's defined, roughly like
>this:
>
>   # @share: if false, the memory is private to QEMU; if true, it is
>   #     shared (default false for backends memory-backend-file and
>   #     memory-backend-ram, true for backends memory-backend-epc and
>   #     memory-backend-memfd)
>
>CON: we need to remember to update this whenever we add another backend.
>
>PRO: generated documentation is better, in my opinion.
>
>Thoughts?
>

Maybe option 2 is slightly better and it's also clearer how to document 
the default for other backends.

When I added a new backend, it was not clear to me how to define the 
default for an inherited parameter.

I would go with 2 if you agree.

Thanks,
Stefano


