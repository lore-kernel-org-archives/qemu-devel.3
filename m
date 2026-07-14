Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C76C44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjij0-0007Xg-5r; Tue, 14 Jul 2026 15:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wjiiy-0007X1-CE
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:23:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wjiiw-0002nZ-8W
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784057001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6zWzMgo06kWcGF07rs2Rniq9AIuMujBPGLRe5QvUvGA=;
 b=G/Rz4Zn4w4XAz9N4OdKGkz+HzueAuARUSBaCEh6Q5Re0b3ShfxGccDpcHYwTGKl3ZmLfoc
 k5xW62Q25jH6wbwJIPxsMviajty86kUifJNlTRd0DzFHdWfNmAHY7BjghlWum6z9eH0aSO
 lJG+KDU7jOLdC5XxrvNQps2loz4dxwk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-HTR6R_ykN2-lgWa4NxOFhg-1; Tue, 14 Jul 2026 15:23:19 -0400
X-MC-Unique: HTR6R_ykN2-lgWa4NxOFhg-1
X-Mimecast-MFC-AGG-ID: HTR6R_ykN2-lgWa4NxOFhg_1784056998
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-476608a9fefso1126026f8f.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 12:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784056998; x=1784661798; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6zWzMgo06kWcGF07rs2Rniq9AIuMujBPGLRe5QvUvGA=;
 b=luVC7RNvn3NkMVm19jABG8bZH89++CDY17HHDZ5ZMhflBq0yLY+exmTfaLkWjTTyQf
 sbt80NMgqq4jDFdFfi2eXJWRAWoHUxIRUsm6CyYfsZ4VixNocTXBaI3vRabjdBns8zrD
 RlbKVx43BC4iQ1uKiDuWEPLFQdnjgnW+YStgETDbUd+3LuqfcGEOizpaNhZp5MxA2Vlg
 4AxqItteQ6R8j62mTbqvI2wKSQOfP80rdX8V4PxcClcElqiDkB80HFIMohZpyXEn0kjK
 LVQp/lpr0gTQdI8tAQgb7GLSGtMrTkYmZX3JpIG+/q0CRuIBxIe6arKnL9qlEii7msSF
 OSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784056998; x=1784661798;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6zWzMgo06kWcGF07rs2Rniq9AIuMujBPGLRe5QvUvGA=;
 b=HfvUYnY1/IfFwDIwbiL/I10+ClFWv0ghX+3io6ELBbwbuL/7JawxCqV8LJu72DdFLx
 +cR58Au6RAYjb+KCAkW6tx+rUCVBKp8nqVdMDF2rvM4vQU1PYnalUaZZAvg+Cpn5xWCo
 0Oyzl8fYbKD0MwEKAAH4cX780xqvVMQkQ/31+mBaxe+MaOu6dKQgh8P/hicl1BWT61uK
 6tUJOUno7Npj+vpU1nqo/Hl7tM2Fc/HZiIGMcTBgIp/jmynwsh1Q4br0P7+3AlWD8lvM
 +qO4JuSV31dtOJeFlZtBTZNoSCP8IQ62l3mdMZnZqV/CByCiVFUQJ9TgjS1FVNNafQ9Z
 rX+g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr1bJDJ26P8JN8HK9eFFiOOlRfwc0+88X2YZWdVaeZATgm53q1sC8QJHtN9OOHHSdVRh2s3gLGwXIeF@nongnu.org
X-Gm-Message-State: AOJu0YxmCPHHO3JFCkZE2xc7fLvOXfM5anoxwrjDJNOiB8eyGk6FAlg5
 lzV1ovVjBIR5MqktVuzkRnN0xWx/jBbRh8XAFgUjhhwxwGuoC0hO2wPzz2qsi2tTYrOBJibI5EZ
 vFRYIrSPkE/W+98Y+Gd8N3OPJE8t1+1PeKQWB3VyB9q3gfro3etUoqnIN
X-Gm-Gg: AfdE7cmBbuBQjDoMHAazk/CFww0fEbLiwd9Uuol2j/Q8HDT6or4fDU5led1QhYstjUf
 EpDU2aQQpXvBMR8tlTTENtcLKO49DZFfOmfyoJLSAze3QlPrbLiQphbCxskhBA34bUvo+5ZSpyI
 K+mR/XmftqR5pYBR9AvGsXk/vWCKnBmlCIHdBU0AW6UTNP+Onw8KCuMJgGs9u13DZddqslZh9Th
 vKx5H9HhWU0njTj5Mp94tYUZCbQMaXHiMQOFg0+Y/fKV4wU5JNfAVfTvkN7TrQT8fvCjU4CftoV
 B8L3dZf9kQ+H2ShPggOgnbNSPJlMaBK+g99hNLFk2uO0a3XkML5c1s78tTtoBgz8Uw/kES8+o0U
 06dKQNlNk7FsmmTKBP4GWspPEjhqQ+CoLkOE=
X-Received: by 2002:a05:6000:25e7:b0:46f:8561:fe60 with SMTP id
 ffacd0b85a97d-47ef697ed0amr20542533f8f.17.1784056997885; 
 Tue, 14 Jul 2026 12:23:17 -0700 (PDT)
X-Received: by 2002:a05:6000:25e7:b0:46f:8561:fe60 with SMTP id
 ffacd0b85a97d-47ef697ed0amr20542512f8f.17.1784056997337; 
 Tue, 14 Jul 2026 12:23:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a973fsm11294876f8f.17.2026.07.14.12.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 12:23:16 -0700 (PDT)
Date: Tue, 14 Jul 2026 15:23:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, alistair23@gmail.com, qemu-riscv@nongnu.org,
 bin.meng@processmission.com, mzamazal@redhat.com, sgarzare@redhat.com
Subject: Re: [PATCH 2/2] MAINTAINERS: Mark "vhost-user-scmi" orphaned
Message-ID: <20260714151629-mutt-send-email-mst@kernel.org>
References: <20260710114305.2961898-1-armbru@redhat.com>
 <20260710114305.2961898-3-armbru@redhat.com>
 <20260711035848-mutt-send-email-mst@kernel.org>
 <65079ad4-3ab9-4ad6-b683-09d46c72b266@oss.qualcomm.com>
 <20260713025003-mutt-send-email-mst@kernel.org>
 <650b9d5c-ca79-447c-b91d-a83d017f42a6@oss.qualcomm.com>
 <87mrvvtibg.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mrvvtibg.fsf@pond.sub.org>
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Jul 13, 2026 at 10:17:07AM +0200, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> writes:
> 
> > On 13/7/26 08:52, Michael S. Tsirkin wrote:
> >> On Mon, Jul 13, 2026 at 08:13:38AM +0200, Philippe Mathieu-Daudé wrote:
> >>> On 11/7/26 10:00, Michael S. Tsirkin wrote:
> >>>> On Fri, Jul 10, 2026 at 01:43:05PM +0200, Markus Armbruster wrote:
> >>>>> Commit a5dab090e1 (hw/virtio: Add boilerplate for vhost-user-scmi
> >>>>> device, 2023-06-28) added the section with S: Supported, but no M:.
> >>>>> This makes no sense.  Downgrade to S: Orphan.
> >>>>>
> >>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >>>>
> >>>>
> >>>> No, this makes sense. The reason this section was added is so that Milan can
> >>>> get copied on vhost-user-scmi but not other virtio stuff:
> >>>>
> >>>> ./scripts/get_maintainer.pl -f hw/virtio/vhost-user-scmi.c
> >>>> Milan Zamazal <mzamazal@redhat.com> (reviewer:vhost-user-scmi)
> >>>> "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
> >>>> Stefano Garzarella <sgarzare@redhat.com> (reviewer:vhost)
> >>>> qemu-devel@nongnu.org (open list:All patches CC here)
> >>>>
> >>>> Pls drop this patch.
> >>>>
> >>>>> ---
> >>>>>    MAINTAINERS | 2 +-
> >>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>>>> index aa2df9cbe3..4d558ddee9 100644
> >>>>> --- a/MAINTAINERS
> >>>>> +++ b/MAINTAINERS
> >>>>> @@ -2622,7 +2622,7 @@ F: include/hw/virtio/vhost-user-snd.h
> >>>>>    vhost-user-scmi
> >>>
> >>> So what we want is to add here:
> >>>
> >>>    M: Michael S. Tsirkin <mst@redhat.com>
> >>>    R: Stefano Garzarella <sgarzare@redhat.com>
> >>
> >> But these files already get M from the match against hw/virtio/ -
> >> what am I missing?
> >
> > Yeah, just trying to make Markus script happy ;)
> 
> Appreciate the kindness!
> 
> In decreasing importance:
> 
> 1. Correct get_maintainers.pl output

Is anything wrong with it?

> 2. Legible MAINTAINERS

We can always come up with a new rule for such cases,
where we have a reviewer just for some specific files
in a project, but the supporters are from the bigger
project.

How about we drop S: completely in such cases?

We can also tweak the name:
vhost-user-scmi (part of vhost)


> 99. My script is happy.
> 
> [...]


