Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609CCEC111A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 18:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vub9A-00086F-34; Mon, 23 Feb 2026 13:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vub92-00080b-Ut
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 13:59:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vub90-0001nj-PD
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 13:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771873135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P0XSb4xt2qRdtptLn6/WGbPmQJ/Ykt+Mg2O2VoVtAuI=;
 b=Ooob+sNm4xSkZ4wNrnWedqukIOYxMQo6bKkLKtr6VD2lgmz/6i9371vJZNElg0Hcq+Wp4w
 +Hj21+KnkmMCwpBdHhpCqxDsvDFWZBK8u0c4Bet7j4O78cOjT94TppDeYg1lDWKmASGiaa
 jc/7wTvHXSZkF9MAmQJ5B0LkGLpZKNE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-Nfcu1JKDO4OPOLpFbj-30A-1; Mon, 23 Feb 2026 13:58:54 -0500
X-MC-Unique: Nfcu1JKDO4OPOLpFbj-30A-1
X-Mimecast-MFC-AGG-ID: Nfcu1JKDO4OPOLpFbj-30A_1771873134
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8946f51b8c8so308659726d6.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 10:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771873133; x=1772477933; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P0XSb4xt2qRdtptLn6/WGbPmQJ/Ykt+Mg2O2VoVtAuI=;
 b=rCU7rgkuKV4+chjUH7+yxp4isOUGzsYLcUFfyj3yRxd+ZVYKwvagv92sB3mhSYhxMe
 RFU0k2JmZCf7U/Mk81whdau6YrHth0wjx1BWwSDeB6ejkvQo7Hbs+nHYBRfoZiByfaXA
 QZt9PNqskLYHIY3zs1LKVzZDjCQjAoQXh2U8EEfkbKhYOYThUYHgTQL7i6ZpMwQwuLn2
 Np+MkZWSDn5y30FkFF8I3SKLjK5r/Lt2E//Y3H5gNcCSvwLQi6t/7FDiXqpKuCfqY6Y6
 sQ7xmB9fgL1/1w/55zvwWLPEEJVW9psgQkNkuHxZ72Yc6P6T8fXRzuOES030xy5K9MMt
 4czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771873133; x=1772477933;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P0XSb4xt2qRdtptLn6/WGbPmQJ/Ykt+Mg2O2VoVtAuI=;
 b=ORLc8G5i2oW1VRnUTSNNycE+f+UWnKCXMvnA8Q+aEWSUohIPiVi/9uCexaP4NPhSKk
 coeqbr3Pxu7GZVaXg7yrmVFEWKduqJ2peeQ8lFmzewU9phCNq5fiQVQ8wM4VXRlqqGTr
 21jCEaa9Xd5WFeR9/9G20taDaH5jBCl+CSUmvTq98lomZ00zVYP0saFCCDJT7VRHD25s
 UWqjEMQJl/AQPA05+JDo0OcWOEdIehBQ+epzNkI8DZXjgXvwivafelP/73QLJG5LemmZ
 xxXyqtc76R+b8s13i+t5ONG+6aTmprfIsIqGJqJ+jCj844NFh2e0bZMvz9LkM6pOeIe0
 8H7g==
X-Gm-Message-State: AOJu0YxEZdFGRO9gbFV9gNeEkjguVyQQ/li5ztiK9l+EqHeOB9LHPMHu
 UsSjihb5hno8rYw/XZgTcnKG2mrhQqrdlxxDJV4VuGkpv0ZFLVuDwwiZqChwMj4MRe5pv+izj/I
 lZll2gYHGx/j2qZ/OIvCXw1OzX9JODdsjROQVVLjlmSHxYjQd0n+6IPv5
X-Gm-Gg: ATEYQzySwDBfUIGuq+K3gTeYGw/sQoQe8gLP9Rl24JMiTJMkElMZy/8sRBXPkVLM6uI
 DpLUjwlMdmH33tE8LMWyK4Ty0Tjjb7XeK0NDVXp/zPk4cy0mJs/N2gZ6f2TelI0Vmxpibd6KiFo
 f09bwvovFaG5ee78tsK7Fc/XYgfA2NV1i11VIlIRoo9uUmEjE4yG91ZzJr8XAm0MpNG8cmxvrQU
 6XleLR8Leo5fG0NjD48FWw0zOc5Tk8nUS65vZoDs/9C5oBHGlRQrxQYaXPNNAAZDtqiAhnVLm+v
 eW0/GrkbMQ5tyVkNbg+iX/v7S1+25xLuMS6Y+1aX1QCE2vWqnziBPtfWUBroz6opZdZ9QosIIcg
 ZEA6jn+rCd3cROlJKvUTxFShuDscCYiYFWDSQDWnVZg9cwa3au1aXzrzmTy14SbcRoHU/gS/Byq
 +9o9IQTg==
X-Received: by 2002:ad4:5f07:0:b0:894:7795:a56d with SMTP id
 6a1803df08f44-89979cd400dmr158986086d6.29.1771873133480; 
 Mon, 23 Feb 2026 10:58:53 -0800 (PST)
X-Received: by 2002:ad4:5f07:0:b0:894:7795:a56d with SMTP id
 6a1803df08f44-89979cd400dmr158985666d6.29.1771873132872; 
 Mon, 23 Feb 2026 10:58:52 -0800 (PST)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8997e62f88esm75075846d6.38.2026.02.23.10.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 10:58:52 -0800 (PST)
Date: Mon, 23 Feb 2026 13:58:51 -0500
From: Peter Xu <peterx@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Subject: Re: [PATCH v1] vmstate: fix subsection load name check
Message-ID: <aZyjaw8Pz-xvZ3AZ@x1.local>
References: <20260220102628.459681-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220102628.459681-1-dtalexundeer@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Feb 20, 2026 at 03:26:29PM +0500, Alexandr Moshkov wrote:
> When loading a subset, its name is checked for the parent prefix. The
> following bug may occur here:
> 
> Let's say there is a vmstate named "virtio-blk", it has a subsection
> named "virtio-blk/subsection", and it also has another vmstate named
> "virtio" in the fields.
> Then, during the migration, when trying to load this subsection for
> "virtio", the prefix condition will pass for "virtio-blk/subsection" and
> then the migration will break, because this vmstate does not have such a
> subsection.
> 
> In other words, if a field inside vmstate1 is set via vmstate2 with a
> name that is a prefix of the parent vmstate, then the field can "steal"
> a subsection belonging to the parent state.
> 
> Fix it by checking `/` at the end of idstr.

Checking versus '\' looks reasonable, however I'm still confused on the
example given, and what problem you hit.

Here, your concern seems to be that vmstate_subsection_load() can
accidentally load a FIELD of the parent VMSD whose name is exactly the name
of the parent VMSD (which will be the prefix of all subsections).

Now my question is, when reaching the line you modified below, it needs to
be prefixed with QEMU_VM_SUBSECTION.  It means the src QEMU is dumping a
subsection rather than a field.  OTOH, when dumping a field, we never dump
any name; I don't think we name FIELD at all..

Could you share the failure you hit in real life?  That might help to
understand the problem on its own.

Thanks,

> 
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>  migration/vmstate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 4d28364f7b..e9901ee349 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -613,7 +613,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>  
>      while (qemu_peek_byte(f, 0) == QEMU_VM_SUBSECTION) {
>          char idstr[256], *idstr_ret;
> -        int ret;
> +        int ret, vmsd_name_len;
>          uint8_t version_id, len, size;
>          const VMStateDescription *sub_vmsd;
>  
> @@ -631,7 +631,9 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>          memcpy(idstr, idstr_ret, size);
>          idstr[size] = 0;
>  
> -        if (strncmp(vmsd->name, idstr, strlen(vmsd->name)) != 0) {
> +        vmsd_name_len = strlen(vmsd->name);
> +        if (strncmp(vmsd->name, idstr, vmsd_name_len) != 0 ||
> +            idstr[vmsd_name_len] != '/') {
>              trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(prefix)");
>              /* it doesn't have a valid subsection name */
>              return 0;
> -- 
> 2.34.1
> 

-- 
Peter Xu


