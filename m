Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9AFE64A80
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIRIg-0000cn-OF; Tue, 03 Dec 2024 06:42:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIRIe-0000c6-9g
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:42:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIRIc-0001T2-9G
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:42:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733226156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kdV+kCaE9Lyhdv1F9WhU4L/Nk8QckqLF6OR7JQI+70U=;
 b=inG4WTVIc/IJRHF3pupt5HVjYvRGriUGXBRDzXURuIi6Up0FQIgEX/yyYQ5zvSOQLIJFlx
 die/GCxlKZijQUzF9bVPv/rIty/88zbA7WY+X/sX0frDlX6yx6QP8z8yW3p7iZMy+sKA8d
 w2p0UbvjplsjETAdc6uQ0C+Xr6S1tys=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-mv-H8Vb6Mhy6RoiTQzas6A-1; Tue, 03 Dec 2024 06:42:35 -0500
X-MC-Unique: mv-H8Vb6Mhy6RoiTQzas6A-1
X-Mimecast-MFC-AGG-ID: mv-H8Vb6Mhy6RoiTQzas6A
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-434a5ca6a67so39789645e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733226154; x=1733830954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kdV+kCaE9Lyhdv1F9WhU4L/Nk8QckqLF6OR7JQI+70U=;
 b=IeGKGEwG1iVw1a66Zz59F2nKXV4CeHjsrhoXL6kFSalWcUTNV0o2rDC08LmQLRX95w
 Ofdb/XsLhtKoSMqioDbYjow+DTtbzbl356TgsPI6MtK2Hh96aWHv18DtkFTgodbrd8d/
 qtgep8r8Q8oqoBEze/QJigideXAHbpiYAbSHgL+t9dfuoByUHkFzEFaK0Xm25Kg8XoPA
 AdVa4kZ2izAvwQxbGV2lIqP2X43tcMnHI+ru3Zrtrf2UoflIN9+pJm+iY4ybipB+cJJW
 OQyObQ3fxy1mM0SMkyBvbLW0nVPIPxBqqhe7sEhRP/6l7fHyA0DPH1u4/G7FjNhNU+WU
 WkRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVqJFMfF5/6NBCONkQfRK8rkqA4Ak6BAE0mKf8vLSCRZMrlvgMiKW87ENROG2xA/8XXV7tyIundNbs@nongnu.org
X-Gm-Message-State: AOJu0Yxc/iNYANjOyhx71WdEJh1VVS5xR5adU/PlJ4xSLZ+52m3Xr9xq
 vYpURwMGIPibDtFooRFZkX/jqNerGJ1cPDKHUqRu8fYNzECpIFNv016Ib4ooIiBef0QNXmHn42Q
 X0sdVq78xjRWCFdhuiO22T3IvlD1cWNE8j/ktOPS0Ytmz44uyZaP4
X-Gm-Gg: ASbGncsix2wOWBIjE38MFTTmmKBBWx/F/1VavCvkt1LThJcnU3QmV5Z4zJM5fkndICM
 DV3CNTwqoUSrh8XjZCeEScJyG6nrbzABXlPD55ZnIxIfagScFEuL7EErncHuBKVDp4f/GvRPTTU
 PeANzFkeGBpQvUf8UvDJNUvxkNWkgCr9ZyrnJYHU09rSpSnJ8fplZyjow2393Xtr4M6M/VLwsJ0
 mljrQJqpbofagkNXcIfY8ME3Q2drRf/3Vad9wL37/VJBtMbyPC9cuJfWyKAP7FkkVMvzQN9KRqD
 1OBHDlCSz7YslforVszXhQ==
X-Received: by 2002:a05:600c:4708:b0:434:a75b:5f6c with SMTP id
 5b1f17b1804b1-434d09bf679mr21243065e9.10.1733226153856; 
 Tue, 03 Dec 2024 03:42:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxNIMxmum8ZNVHTxSVk7U02XMS5k10BcA7udiCBF1F18eXmzrvQxBopFgxD6upbMlqusfpMA==
X-Received: by 2002:a05:600c:4708:b0:434:a75b:5f6c with SMTP id
 5b1f17b1804b1-434d09bf679mr21242765e9.10.1733226153544; 
 Tue, 03 Dec 2024 03:42:33 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0dc9827sm185133725e9.26.2024.12.03.03.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 03:42:33 -0800 (PST)
Date: Tue, 3 Dec 2024 12:42:32 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/15] acpi/ghes: make the GHES record generation
 more generic
Message-ID: <20241203124232.7948b2fb@imammedo.users.ipa.redhat.com>
In-Reply-To: <b3845a8c78ef36c633d5e20af868de4ed16650a4.1732266152.git.mchehab+huawei@kernel.org>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
 <b3845a8c78ef36c633d5e20af868de4ed16650a4.1732266152.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 22 Nov 2024 10:11:25 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Split the code into separate functions to allow using the
> common CPER filling code by different error sources.
> 
> The generic code was moved to ghes_record_cper_errors(),
> and ghes_gen_err_data_uncorrectable_recoverable() now contains
> only a logic to fill the Generic Error Data part of the record,
> as described at:
> 
> 	ACPI 6.2: 18.3.2.7.1 Generic Error Data
> 
> The remaining code to generate a memory error now belongs to
> acpi_ghes_record_errors() function.
> 
> A further patch will give it a better name.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
[...]

> -    return ret;
> +    read_ack_register = cpu_to_le64(0);
> +    /*
> +     * Clear the Read Ack Register, OSPM will write it to 1 when
                                                 ^^^^^^^^^^^^^ typo?
> +     * it acknowledges this error.
> +     */
> +    cpu_physical_memory_write(read_ack_register_addr,
> +        &read_ack_register, sizeof(uint64_t));
> +
> +    /* Write the generic error data entry into guest memory */
> +    cpu_physical_memory_write(error_block_addr, cper, len);
> +
> +    return;
> +}
[...]


