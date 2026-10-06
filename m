Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24A4CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN2B-0002dS-8V; Wed, 07 Oct 2026 04:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xEHiw-00069b-Nh
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:49:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xEHil-0004Jl-Qt
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791341313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+NUM2DajgTvHfa2tOlFEsHRgPTBQv++tkYzu6/+Iho=;
 b=RVNzDJvHZe5bwDlvpHw93hy+/b4JX/LbvRILMlpFY/w9OGP0VyRq8q3Aru1SKv6ZTF3VFu
 2JbclWl2NabTFAPgAdUh4i/yr9nmIvKMZoZcJSPICQm6BXtRxY0g/tj2Fvqvndwzr8xQtF
 4T3mTcsr+Q/P4W6+JxhAQ7nUnWNTgQM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-QSP_kYQoPFSNqZfKu0iQ9w-1; Tue, 06 Oct 2026 10:13:27 -0400
X-MC-Unique: QSP_kYQoPFSNqZfKu0iQ9w-1
X-Mimecast-MFC-AGG-ID: QSP_kYQoPFSNqZfKu0iQ9w_1791296006
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48af5a07314so2108079f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 07:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791296006; x=1791900806; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I+NUM2DajgTvHfa2tOlFEsHRgPTBQv++tkYzu6/+Iho=;
 b=IF1IrEr4vF3QwYZW+TvA7EWP5af3qMLNnKfQ2Gx4KEmmpkcA6EMGg08EtKcuyQ5IHE
 Lexzsw+q24bjhvblmkPFzTnxeVv028J6L2VkcrMtanx8S6+GhAQG0tPC1V1Jy2xQLyH2
 uQnF/7535rEzPGSGV+IXT/ld0DufC4ljOYDdcGCXmRbFnFoqUjPKlQOyB0fgzFL5AUqR
 NY0j/SWdAEMtAOjTbGqZ/gMseXNla0OIjfMTQqkNjSmuxW5TScE/R76RU0v+HgvWk+NT
 o3JWPiE8Qj+hubJXQ/u4LaUv5ap6FUEVFJt3FwkBbM2DwD2K0osi/EoU86D6j7w+YW1s
 /Ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791296006; x=1791900806;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I+NUM2DajgTvHfa2tOlFEsHRgPTBQv++tkYzu6/+Iho=;
 b=fsvN+kVOPg79Gv5gPc4EnlTatGw4cZUHpgRs8B9m7TjFeJlXwh4hJ0DT44hZKmr9Un
 ssBTXE9NxhnAAgUx2rLiP5G8iO9eYMrSLWcts5qKjzqjrTfItzb9StsLBm1a7WhY5C38
 +idZuq8/Rf0B3ZB1iRDIYTa626FHU/prkswQbTi5GICWIsOqfa9wZv9+bmQLhp1Zsj6R
 Nrze7fml93YarQG789nQpuYJBHGyFrgu/D8SRu1fwbhFv2+rwonavOZz8CIqnoaI9bOa
 Ku5ClcfF7hzXBX+0Q3h8nxEZYnw8a4NY9Fvn4hMJB0E+EKEXwJMmCT3Nye6jI16HOiwG
 cmRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQlM3+obR1s9cBNvZkIFnnhFxoAQFVUJe4jdZjVl6Mx8GQZv0trlRmVrAP7bQ4DuPSTx6qdeQ7ERqB@nongnu.org
X-Gm-Message-State: AFq9FYLVu1LrFqETCLC/rpFjDQEeuINc8Vqpsr+AnIQp8U7RC9EGET6x
 KJOs4c/X9UXyckbn/Bo232FFDkqDDgAddjHyk4GYYvcn/jp6tkPx/aIRsM0VVms3jaoEWqyAlPW
 vmxyzIJMTqg7S4/edZToYCT0uwVRwxzop7pdUZ6i0/GalkKgHPTZki0kD
X-Gm-Gg: AYBFou1H38DGjJBxdESXeCA0xwF1GEGt195XHxNxmu3CqzFaNsKjRHM9i/gvnGg9psX
 WsHWib+/PxVfERyBRAh63sRw8KgQZ3PO/Y/hD8HeaDWHZxpO1XjroHqrK3qRlmj67HNmBzQ2mkB
 ANrn62b9j/7799uKpl3jD3xiq6htnqSnt2wVDyN9Gqgqrf41A+pPzfoIn6Vm75hCB4tIks+TFzj
 zV7uooBxWQOm8C87o3JpGJZuIFKeTIM6HhDuSPOmnkPkCx95ZFZLTWlCgXJfFtw9I6FlEL9434Y
 6Y6COEnzR2rE6GttjBX17w9JJqPkXd2DLdkzGpPKEx1sg4gr6YjXTbBR91XOTq7jx0P+RRek7HN
 6C6GVYEueajQEWmx4gtDaA07SsXWnqN39g/8=
X-Received: by 2002:a05:6000:4b04:b0:486:f6dc:52c8 with SMTP id
 ffacd0b85a97d-48c6d1981ffmr2742522f8f.37.1791296006269; 
 Tue, 06 Oct 2026 07:13:26 -0700 (PDT)
X-Received: by 2002:a05:6000:4b04:b0:486:f6dc:52c8 with SMTP id
 ffacd0b85a97d-48c6d1981ffmr2742466f8f.37.1791296005676; 
 Tue, 06 Oct 2026 07:13:25 -0700 (PDT)
Received: from leonardi-redhat ([176.206.38.69])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm11145824f8f.37.2026.10.06.07.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 07:13:24 -0700 (PDT)
Date: Tue, 6 Oct 2026 16:13:17 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] igvm: add command line parameter support
Message-ID: <asUByBuZl_qE2ux4@leonardi-redhat>
References: <20260930-igvm_command_line-v1-1-62857007d89d@redhat.com>
 <87qzi9alml.fsf@pond.sub.org> <ar4V1i54Czo45lQh@redhat.com>
 <87jyo1akr1.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jyo1akr1.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 01, 2026 at 10:27:30AM +0200, Markus Armbruster wrote:
>Daniel P. Berrangé <berrange@redhat.com> writes:
>
>> On Thu, Oct 01, 2026 at 10:08:34AM +0200, Markus Armbruster wrote:
>>> Luigi Leonardi <leonardi@redhat.com> writes:
>>>
>>> > Add a "cmdline" property to the igvm-cfg object and a handler for the
>>> > IGVM_VHT_COMMAND_LINE directive, which copies the string into the
>>> > parameter area the directive points at.
>>> >
>>> > This command line is intended for the component running at VMPL0, such
>>> > as SVSM, rather than for the guest OS, whose own command line still
>>> > comes from -append. SVSM can use it to select the serial port it logs
>>> > to, for example.
>>> >
>>> > Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>>
>>> [...]
>>>
>>> > diff --git a/qapi/qom.json b/qapi/qom.json
>>> > index 5895c97750..d56bdef561 100644
>>> > --- a/qapi/qom.json
>>> > +++ b/qapi/qom.json
>>> > @@ -1004,11 +1004,15 @@
>>> >  #
>>> >  # @file: IGVM file to use to configure guest
>>> >  #
>>> > +# @cmdline: command line for the software loaded from the IGVM file,
>>> > +#     rather than for the guest OS.  Ignored if the IGVM file does
>>> > +#     not ask for one.  (since 11.2)
>>> > +#
>>> >  # Since: 10.1
>>> >  ##
>>> >  { 'struct': 'IgvmCfgProperties',
>>> >    'if': 'CONFIG_IGVM',
>>> > -  'data': { 'file': 'str' } }
>>> > +  'data': { 'file': 'str', '*cmdline': 'str' } }
>>> >
>>> >  ##
>>> >  # @SevCommonProperties:
>>>
>>> How is @cmdline going to be parsed?  By a shell?
>>
>> This is something passed to the guest workflow. ie a kernel command
>> line string.

yep, correct!

>
>Not obvious from the description text.  Please make it obvious.
>

will do!

Thanks,
Luigi


