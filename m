Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1B4C35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 03:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvTC2-0001c0-Qw; Thu, 20 Mar 2025 23:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tvTC0-0001bg-NZ
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 23:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tvTBw-0007UT-7W
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 23:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742528221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FrzDjjL8tp4iVjA29czLq0e12LhTBSmBhmOHyhQlqYs=;
 b=iqTQoo5avnjTMKU/70L6ERsBHRjIRhnCAgW+3d+7UI+sHSePimWSycxjav13iC8JHmxAKL
 p9EP000rDV1zMKzAh8Ut5lji8ao8zkAEsczc3ANXhTGdE5S9KnfEUbcBs3Ym+dj3aqTooA
 DEmxe9xw6zumrrksolAAj08ho3frBSk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-BJ8AYmRJNIiRocPZKTsdyA-1; Thu, 20 Mar 2025 23:36:57 -0400
X-MC-Unique: BJ8AYmRJNIiRocPZKTsdyA-1
X-Mimecast-MFC-AGG-ID: BJ8AYmRJNIiRocPZKTsdyA_1742528216
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac28a2c7c48so142492766b.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 20:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742528216; x=1743133016;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FrzDjjL8tp4iVjA29czLq0e12LhTBSmBhmOHyhQlqYs=;
 b=Q8vYCNGhSrtE3CkLHEm30XQ07xwOYWQjZyVdzDdbGh6F08d3Ws9zUZYuW9X0XW7aDn
 OhNUrjd50h8VsJt8X2c46+2gkfHY4sIH+YXfVkdupRcdapePZ0Cv2t5Cb3Gl8oy6jO2P
 F7EP+egWNFLB50HW9SowkTAiyrKFt79BazwRbSAplFbqfMYs1n5PnVNEbVBRpcqpQMcP
 ad7HBI/X1kujXN/hfhmBmIlTxlPo44hYGobXjx2EhkvTgzu8n+iK6+NACV7GMn9vSQ/n
 Ux1KS8Gy0TtkfLMvotY0W1UucuzLzGKUEmp3Ldiiwx6L7uOxZ4ZUWhpueIRx5ilO4/m9
 uV6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI+p8tAb1uTEGVsppbLQqAlb2mbsdv4GQOj7I96VDm8pf6TT+zTOrszM9cXCO/9dbLIbSslzLyL4dV@nongnu.org
X-Gm-Message-State: AOJu0Yz3VW9TMPEnLPNi+d8/qcl80HAcuNC0TLy1UmbQ8tFGtM09prLb
 3q3Un0zL1N89QlDTlMEUcofDAHx//uXegWUjX64nhkDuJHHtJT/R9BhfwID32xfBJf1CpKmtwYo
 pVOQ2wujNnzj9zYFlTulG75ryVXqmnjZHcw3PByJpBDZMUfycdwqEqxCnlWbrHsbIpuqzdqg3mh
 J3H3acZG3InKwig6+lxN9DDYkmIZ0=
X-Gm-Gg: ASbGncuPT0jxU8uRbqNz7ZBa1+6Jde1iTbirUPIreNc4XT48xKN22BHttt3ARy6oyZi
 dJCPKvq2QuIPaOSWCnFj78LFECGHBGxpaOVWjmR0ayEx+1+RkVMbiomjtUlyzgC+fnq9LmGVr
X-Received: by 2002:a17:907:97d6:b0:ac2:9683:ad2c with SMTP id
 a640c23a62f3a-ac3f25412cdmr168069666b.57.1742528216193; 
 Thu, 20 Mar 2025 20:36:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpU6y8sgMCA4mO7EAU2qRclAYKk9S3ZUewc2GzJh57zdPn8eLFgPtA86Eef/mNJSPEUFAo0eBcSmwl5wzAa5s=
X-Received: by 2002:a17:907:97d6:b0:ac2:9683:ad2c with SMTP id
 a640c23a62f3a-ac3f25412cdmr168068066b.57.1742528215862; Thu, 20 Mar 2025
 20:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <sxavsa2i4drnei4kmy6pd4uekk3xaa43njd47jtogar7ui7qm7@n73chaex5ms2>
 <Z9LeILiEU5GfEHrl@8bytes.org>
 <CAK3XEhNS10gKLh6SKeSc9cKi+_qwu3+Yu5rAkni5h7tYS59D5g@mail.gmail.com>
 <aet7vo4qwexxrw5khiwvhelvhwya3w7wuk72w77jlq7idn3me5@2ojjjdw43u7q>
 <85a9745d-e3b3-4e0e-90ad-066e6dcc25c1@amazon.com>
 <ahtt7arm3pi7rlv6x4qepktrczgnsgaukftyee75ofn5duviho@v4wp6v7wlxbg>
 <4593a2fe-098b-488b-9d55-1adc1e970f59@amazon.com>
 <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
 <6684f169-29d6-4f46-b274-1efd4c191b21@amazon.com>
 <ok6u7exmwmh7qsahp5o3udnbbzbsr2km22kpqod37t6mdsywcs@yhk2whhakl63>
 <fucfv6gf22t3sclhad4iwbmxi5tdg6a5dlhvl4kl4bzhnjkktu@dtn2eqh27k32>
 <c7f840d5-19ed-493e-8de8-7d64aef38948@amazon.com>
In-Reply-To: <c7f840d5-19ed-493e-8de8-7d64aef38948@amazon.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Fri, 21 Mar 2025 09:06:43 +0530
X-Gm-Features: AQ5f1Jpiai14kE0q29p88KmqS8jr5g9hkJFtEiNfGtbzeMsqw22i-5QkirLDoxc
Message-ID: <CAK3XEhO4BMvDBe667=_xe9+A7pN4_N_nkGh0KH12Pq_qLu9AWQ@mail.gmail.com>
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Alexander Graf <graf@amazon.com>
Cc: Gerd Hoffman <kraxel@redhat.com>,
 =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

On Thu, Mar 20, 2025 at 7:24=E2=80=AFPM Alexander Graf <graf@amazon.com> wr=
ote:
>
> Hey Gerd,
>
> On 18.03.25 12:11, Gerd Hoffman wrote:
> >    Hi,
> >
> >> Maybe not from the user's point of view, but surely for the vmfwupdate
> >> interface design and for the launch measurement calculations.
> >>
> >> When using igvm parameters for the kernel hashes we need to pass on (a=
t
> >> least) two items via vmfwupdate API:  The igvm image itself and the
> >> kernel hashes, so the VMM can fill the parameters for launch.
> >>
> >> I tend to think it makes sense to keep the region list, so we can
> >> actually pass on multiple items if needed, and simply add region flags
> >> to declare that a region is an IGVM image.
> > Went over the interface spec today, here it is.  Changes:
> >
> >   - Moved descriptions into source code comments.
> >   - Added leftovers noticed in recent discussions, such as cpuid page.
> >   - Added capability flags and region flags for IGVM.
> >
> > Open questions:
> >
> >   - Does the idea to use igvm parameters for the kernel hashes makes
> >     sense?  Are parameters part of the launch measurement?
> >   - Do we want actually keep the complete interface (and the functional
> >     overlap with igvm)?
>
>
> I think if we want to embrace IGVM, we should embrace it fully and make
> it replace the region list. At the end of the day, IGVM is effectively a
> region list plus data.

Are you suggesting that vmfwupdate only accept IGVM as payload? I am
not sure if I like that idea.

>
> How difficult would it be to put up a prototype that uses only IGVM as
> vmfwupdate payload? We can definitely assemble that IGVM in ukify.py or
> as part of the boot stub. Or for the prototype even pre-assemble by hand.
>
>
> Alex
>


