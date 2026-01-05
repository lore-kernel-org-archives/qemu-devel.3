Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8382BC79F8A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 12:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcjhQ-00063V-R4; Mon, 05 Jan 2026 07:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vcjhN-00063D-Cs
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:28:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vcjhK-0003kV-4s
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767616106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oeAvzEB467+Hu1DvHk4tGBKVWIm5hWP5gKSdmzYmtCE=;
 b=CP0wOleN8Bkx7g7lQgX8eUhzmjO2aC0puSDv91KB0UIN/DyZt0YXPYI/yrtyQrrYrnXQ5F
 /QA59zT+dkZzn9ng4GjF7+uvTDI+nZaHMNVViSm6sPwLhtsib6mTQ/I5H2CGP2fnMfyFp+
 74EwHNwYZFm/XEeI+fGsFlYEEvFe2IE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-DvCPP-V5MPWdZA_cg78a6w-1; Mon, 05 Jan 2026 07:28:25 -0500
X-MC-Unique: DvCPP-V5MPWdZA_cg78a6w-1
X-Mimecast-MFC-AGG-ID: DvCPP-V5MPWdZA_cg78a6w_1767616104
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b83623fd3bdso838885566b.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 04:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767616104; x=1768220904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=oeAvzEB467+Hu1DvHk4tGBKVWIm5hWP5gKSdmzYmtCE=;
 b=GRhSjif/gnV7gfJVKcg+JEWSBYEgWZghYm4qhmuY6AA+8Pnrkk1+Y2wICjgza2+4X9
 pR6gs771eKLO4Z+uf3yZP/jktZqQqcMecpFHeJZyl9QTK4xVn+f7otvmunmf84qwXdC1
 87Lyqha5ziUdL6fSxTKfWa3ZmL3Dn491j85Q/FzYVOwPExErWQ/vQsTitnSJNyCeFlk4
 p+UBwR0FoyqUrFHZgZpul281M0+IPc3/14SplhmC8FVHBPfIsAK/mVmRWZfmA5j1uDfy
 zz4mO15iNXfn69vZ9dzCCpToxYKgkwPesWCSzhyQb3nCtF2QiaJWg2zQbsgiqf3VsVM0
 nSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767616104; x=1768220904;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oeAvzEB467+Hu1DvHk4tGBKVWIm5hWP5gKSdmzYmtCE=;
 b=UhMfNR6OpeQJHrZBPr+okeVJlOeMjTJZTfx+HLb7k6jmL4E/I/pGH8G2+4bOABqUhA
 EvSjqXsm6xGFhOq9Rt5eVa+k52Ly+1IpWup+2Hie636E5rDT7KQUchX0NfgVDaIyVc9G
 bBADvNJPgB5vFG3dChWLTOFrOzhMWbfKh6gmgXovr4+I6LOZ3TTQKWbPRoZIE78Y+hxP
 nkYG+VWYIm4ic8Ypk9I4/QNFaqmqQhmibevxqAwmOukSw3XfYJnE3ITfjcsA+v3AM3GH
 xdCUQ6pHfCtZ0p2anbG3hNtCmNufwt3KNPh9Ze2Ifs/yuVa9VuEj72wJmjGJNMr50mZ7
 DbrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu4HZQvf4i490r1+nZIYoPsov1Aau1oD5IHdj8IpWQ5JuX8qolo7gCeFmC1cfL6FzUbc3Pisrf3wXj@nongnu.org
X-Gm-Message-State: AOJu0YzZAjIoy//+khV83QSY+XmjU85CIlibP0ESSzF6/6NtR1j9al3T
 8o93tuTTzGQmRkhrLvXjtaFiWHcFcQ93d5E5Pvg2uD/alQtE489dZfqXYAAYYygf04iC6oLDSKb
 kiQkF+WVLo2+bKU0+3uZWuGPjLrkBf6iNzaDrNQNqzlaPptcV6WfwKcFZ
X-Gm-Gg: AY/fxX75G32hVB6tCHdFgpJdX4puDrYU3Imxx/mfCdLLhOKIaAINBKyDPKbdWOyCvJG
 hVoSz2YHwGyf8DzEC4tsSA0rImpA0MDT4slAQhH1qnv47PfWXa+KtoIsSkElmTADvj0yExee/dm
 HZayqFbFDG6teA1E56agL6TBILbLgx6zZ8RFDFXWjRJTwtHNqqwpxsbevWIRY5eZcqkLAgxq7ZI
 p7KN1GgRl55G0Xhgai7/1EH9jX5IExbsAYnagQnZgD1DWOVko1ejWaz0Uxs8lkL0EaRWooio9Zo
 FeLpWJO4XnJGYHB8hhA487EJAWPbiE/ccr1A2Z7mQzDhnWViY1MFsqCA778DzzzR1u0hji0wpnk
 a0HxiE7V9nIdCk6phEQnhJg==
X-Received: by 2002:a17:906:cc14:b0:b80:3738:2f11 with SMTP id
 a640c23a62f3a-b8037383b68mr3704946566b.13.1767616104225; 
 Mon, 05 Jan 2026 04:28:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1C/UgAqifaaLnU+Rqo6/KtnD7PLthTdmzsa7KAFj4nOaFcBlZQm1yh5Pzot0uyAn3r6SX6w==
X-Received: by 2002:a17:906:cc14:b0:b80:3738:2f11 with SMTP id
 a640c23a62f3a-b8037383b68mr3704945466b.13.1767616103809; 
 Mon, 05 Jan 2026 04:28:23 -0800 (PST)
Received: from imammedo-mac ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037de0de1sm5568657866b.40.2026.01.05.04.28.22
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Mon, 05 Jan 2026 04:28:23 -0800 (PST)
Date: Mon, 5 Jan 2026 13:28:20 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . =?UTF-8?Q?Berrang?=
 =?UTF-8?Q?=C3=A9?=" <berrange@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Markus Armbruster <armbru@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Philippe =?UTF-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, BALATON
 Zoltan <balaton@eik.bme.hu>, Mark Cave-Ayland
 <mark.caveayland@nutanix.com>, devel@lists.libvirt.org
Subject: Re: [RFC 01/10] qom: Rename ObjectPropertyFlags to
 ObjectPropertyAccessorFlags
Message-ID: <20260105132820.4a411827@imammedo-mac>
In-Reply-To: <aVtuOHU6xmhuDx5v@intel.com>
References: <20251202170502.3228625-1-zhao1.liu@intel.com>
 <20251202170502.3228625-2-zhao1.liu@intel.com>
 <20260102131253.5b60853b@imammedo-mac> <aVtuOHU6xmhuDx5v@intel.com>
Organization: imammedo@redhat.com
X-Mailer: Claws Mail 3.11.1-67-g0d58c6-dirty (GTK+ 2.24.21;
 x86_64-apple-darwin14.0.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, 5 Jan 2026 15:54:32 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> Thanks for looking at this!
> 
> > > Therefore, rename ObjectPropertyFlags to ObjectPropertyAccessorFlags,
> > > and then the original name ObjectPropertyFlags can be used for other
> > > cases.
> > 
> > I wonder if we can  just make existing ObjectPropertyFlags per object as you are planing
> > and still continue using it for accessor flags.
> >
> > That basically will lets you use new flags everywhere without rewriting call sites
> > everywhere.
> 
> I'm not sure about this. Currently, these read/write flags are actually
> specific to pointer properties (as showed by the changes in this patch,
> which all involve object_property_add_*_ptr() / object_class_property_add_*_ptr()).
> 
> Other property types doesn't yet support flag parameters, so additional
> interface modifications are still needed.
> 
> And for now other property types either need to explicitly specify get/set
> accessors (e.g., object_property_add_bool()) or directly use the default
> get/set methods (e.g., object_property_add_link()).
> 
> If we extend read/write flags to other property types, such as adding
> "flags" argument to object_property_add_bool(), we must ensure the
> OBJ_PROP_FLAG_READ flag align with "get" argument and OBJ_PROP_FLAG_WRITE
> flag align with "set" parameters.

Ain't thouse accessors callbacks?
/I mean to you still can check flags inside of generic object property code
without touching setter/getter./

>This would introduces additional complexity.

it still might be woth considering to compare this series with alternative approach.

> 
> Thanks,
> Zhao
> 


