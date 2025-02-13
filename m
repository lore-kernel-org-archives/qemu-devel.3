Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52580C021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibu8-0003DU-2m; Thu, 13 Feb 2025 11:17:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tibu0-0003BA-RK
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:17:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tibtx-00080z-Rm
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739463430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GeAlL+1AzeNTPsRQ3WHe8FvtX8RVdZ1WH1mrHyX0XPk=;
 b=EtkdrHZNjv8j0DBfE1bzeU6swDXhioeo2pLhW+zXc0TPOXrAAAccVyLa5RRs0kGyTpP/dh
 p7R0Lc6FomXwkFrzxe4SNMsBqhYhrpTc32LyUKqPgMGLkU13yzZaD09P6JlEXlGjIe64Rz
 ZZ9r87vH0ZXLb/WblWBxB0JqPLCAPxs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-BSUTO2dPOiebK1IFCxktHg-1; Thu, 13 Feb 2025 11:17:08 -0500
X-MC-Unique: BSUTO2dPOiebK1IFCxktHg-1
X-Mimecast-MFC-AGG-ID: BSUTO2dPOiebK1IFCxktHg_1739463427
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38ddcb63ed1so744283f8f.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:17:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739463427; x=1740068227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GeAlL+1AzeNTPsRQ3WHe8FvtX8RVdZ1WH1mrHyX0XPk=;
 b=ajKMkw4em3loPvm2nkkJTZn5NO973XrbNJdeylgrE887gCN9klNlKe/HUaICxUz/DQ
 0hXzlzrJXFsqOnsZ8i0BkuAv0uoqVgoSuO5Q66uhy5ZCbezuu8fmoo6kYWYoK6pqs0bb
 FdaU480hU4unYYM5R2Qm+gDNGQZaRc3eJaBEGtC7gcn87rlcfDij6mhudNoVC3iL0PXZ
 zBo6LJ0EJhqDc1GxRU0BHaicf+NycnmvJtVieqw6jo2bEmPZ1MBHbkKqlHmXfr0E443N
 lQCXk81/XVvNkkcEC1UFWmmQ+CAtzJ23id5cVEbVSELTGNFUYhBVpmvih5mJd9BmHfaX
 mC/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfggQowtRgU02lQY7w8BvXaBrd8hid3JfN50VtWGJiisaBpCQY6ednF2sN+E2qCqmOMcfKQWQ4OnjJ@nongnu.org
X-Gm-Message-State: AOJu0YwZFUh4VNwEIuizKT18n/zm6mKXTRROW+rUOy77A+1opCRP1Vo+
 KLAEOLYPRhdkHkHPJeBjiQQki7T463EO1xmw2nx4YPyYQFcMWcoERseq3vxXuxgP16Ogj76/1yM
 CeVs+3PjlP3vb/OMMvr7SAQaCgesy+zRVh/ueGvICNHyX0A5tMxQr
X-Gm-Gg: ASbGncvjRApwWVt615R/M9EsNDYupehD3p7QRC0ZCKuu0sVUvjk+KzLjHhHwz4UW5Y/
 ek1eBRnoPQD7jhqBj7pxInVOxKMZbawHVHzjZKHRy1sKGNVId8guUNzhBh7BSzZtrDr0CHsasai
 LeJclTQsQfIKHT5t8xO6dXHpLs4gVpLObQPloHG108qFi8R21bDxJStHLrsSLJcZXh2PrIgFbPs
 QymiSg7QP9PNB77EjO8xhFbGYgqhWOuBaunYaEZRErIGhwVJ+pp/sVFBvwxds6rsCVbZLjcUbBg
 Rv3O5mLjoksfD4nrL48WYkJl9jJ0PMfLzy/TuOlSzwiDhhNt6+gE
X-Received: by 2002:a5d:524c:0:b0:38f:28dc:ec23 with SMTP id
 ffacd0b85a97d-38f28dced84mr2227719f8f.19.1739463427286; 
 Thu, 13 Feb 2025 08:17:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlG5uu37yM2Hh719O7QAR1k/85Z+uGhO4V+nOToCFbwcw7kgc+KqK/PqWPFa8yEDY14KdWmA==
X-Received: by 2002:a5d:524c:0:b0:38f:28dc:ec23 with SMTP id
 ffacd0b85a97d-38f28dced84mr2227689f8f.19.1739463426933; 
 Thu, 13 Feb 2025 08:17:06 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258dcc45sm2307145f8f.33.2025.02.13.08.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:17:06 -0800 (PST)
Date: Thu, 13 Feb 2025 17:17:05 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: gaosong <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, QEMU
 devel <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH] target/loongarch: Add full type support for
 query-cpu-model-expansion
Message-ID: <20250213171705.6dde38cf@imammedo.users.ipa.redhat.com>
In-Reply-To: <87a5aqhxpt.fsf@pond.sub.org>
References: <20250213091626.3650603-1-maobibo@loongson.cn>
 <30c1c330-32d1-fa36-c0ca-670c94a06736@loongson.cn>
 <87a5aqhxpt.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
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

On Thu, 13 Feb 2025 12:48:30 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> gaosong <gaosong@loongson.cn> writes:
> 
> > Cc: Markus
> >
> > hi, Markus
> >
> > What is the difference between CPU_MODEL_EXPANSION_TYPE_STATIC and 
> > CPU_MODEL_EXPANSION_TYPE_FULL?  

the only difference is that 'static' expansion will not report properties
not mentioned in hard-codded CPU model definition see: builtin_x86_defs

while 'full' will iterate over/report all rw properties of CPU object
created from provided model name.

> I don't know :)
> 
> Here's the documentation:
> 
>     ##
>     # @CpuModelExpansionType:
>     #
>     # An enumeration of CPU model expansion types.
>     #
>     # @static: Expand to a static CPU model, a combination of a static
>     #     base model name and property delta changes.  As the static base
>     #     model will never change, the expanded CPU model will be the
>     #     same, independent of QEMU version, machine type, machine
>     #     options, and accelerator options.  Therefore, the resulting
>     #     model can be used by tooling without having to specify a
>     #     compatibility machine - e.g. when displaying the "host" model.
>     #     The @static CPU models are migration-safe.

Looking at related x86 code above description sounds like a fiction.
Both 'static' and 'full' do use
 qmp_query_cpu_model_expansion()
     x86_cpu_from_model()
         cpu = object_new(foo_cpu_class)
         x86_cpu_expand_features(cpu)
and the later 2 calls are subjects to being influenced by:
    "QEMU version, machine type (compat machinery), machine options, and accelerator options"
and -cpu option

>     #
>     # @full: Expand all properties.  The produced model is not guaranteed
>     #     to be migration-safe, but allows tooling to get an insight and
>     #     work with model details.
>     #
>     # .. note:: When a non-migration-safe CPU model is expanded in static
>     #    mode, some features enabled by the CPU model may be omitted,
>     #    because they can't be implemented by a static CPU model
>     #    definition (e.g. cache info passthrough and PMU passthrough in
>     #    x86).  If you need an accurate representation of the features
>     #    enabled by a non-migration-safe CPU model, use @full.  If you
>     #    need a static representation that will keep ABI compatibility
>     #    even when changing QEMU version or machine-type, use @static (but
>     #    keep in mind that some features may be omitted).
>     #
>     # Since: 2.8
>     ##
> 
> If you have further questions, David Hildenbrand or Eduardo Habkost
> (cc'ed) might be able to help.
> 
> 



