Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D943ECCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 20:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9UaH-0006cz-9J; Thu, 16 Oct 2025 16:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v9UaE-0006cd-6x
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:28:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v9UaA-0001ta-EL
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760646496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8OpYmmS7RTSQRRONh48/3pzXrN7eF/KK/I/jDf0NKTE=;
 b=ckrox5JHR/OWgHn2NENC6qGkDezBJ19uL9xmzvDbLgGLDclMK1KltIpcnwz2haeWDlv2yb
 MDLDsf2eJyRrsDY101oH2VWmE42Er7AeKMHT5y8h9m8bQcwwMxrB0oHdJbvzHdMhtCPIY0
 bCBaYiFm6v6RwzmTwD5RSYWTKWWS7uc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-hiERk3jUPGmjR5b_4DDOvQ-1; Thu, 16 Oct 2025 16:28:14 -0400
X-MC-Unique: hiERk3jUPGmjR5b_4DDOvQ-1
X-Mimecast-MFC-AGG-ID: hiERk3jUPGmjR5b_4DDOvQ_1760646494
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-87c1558a790so39474046d6.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 13:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760646494; x=1761251294;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8OpYmmS7RTSQRRONh48/3pzXrN7eF/KK/I/jDf0NKTE=;
 b=AcTRZLFX00dwwreJpCLcFJIs7ykMJaTSouXaVSharSnKFz4AiH0GL6kddH8TplaZTd
 674D+17KynGLmFFbE/TrEMd9mnS9Dk1g4nY0w7coTr1ImI+688jaHnHrDj8fU1eHARoK
 BpOwTv5tr1LsJ61wh+QWP8NSyqfj91A2yg+0kTvmXYvH5xBFSeWsXP5NUr4tPqWoo4Fa
 Nte89od3JICTynTTMaIyZfR0+rbe6MzrSFrEdxFz5YPHtOsmrKStaGHJD9ErbrwOvSgH
 8up8Yw6Gq6Mj4sAcBFnUU3H7QUoJ3zIjHsb3z4l5KcqbXMNkFIx1KBFCXO4ezSbt9y0E
 sPTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoe5Hy2fxiK8CAxxUxJ2ym3Zlk0VnlE2qNSgAoTw71lxLWo388iADf8QK7JUSG2I9pFAr0JF8PfnQ+@nongnu.org
X-Gm-Message-State: AOJu0YxGTLBkqp/XAlFOfZg5nb+Ed26AQLjQBvV4Kwi0s+PfTKJ9jKYE
 DisdENW5tb5A+dm8egoSjaEIAbjTYHr9hfCXCxZhO8hR1syr9GohmN9PqnV+WHSRyKpzFWG79Hg
 aGIdQhe5T34p0vf6ynEYP7gzEXVx/kAroc/R0vhUpnIB1oCn2YtlOTrCm
X-Gm-Gg: ASbGncsSv5eezLJl7UYmYawySjEWModqS7+F2voY1wS9C3rFzR3N2WoCZbHD67MaTVN
 cKRh4B/Vg7pen0BXZHznM8FJ3bcdaIcZtJT8+vhoszpNLB3XjfuO8lIK1fwkcS05DbZPR8syq+G
 jEc6aTxMk+cCNrMIsiH/Vh5zaSVxXNN+UTfXdo1QwwZim66IjFVCrTyzNELqsZDpfHQLHj8giRG
 Ir6LtB57SlaCaJebmyWVGRTmtA65pw/K7UgNJrfqwMwum0xHzoIE4SjbQemxA0F6r/Lv8YfiJ1J
 v818mtNcCd4KuvLKQijIm0NxNJyfRBYk+XyGEzSEpmNBN6s1txs3kqq5IUuPVdssdL4=
X-Received: by 2002:ad4:5f4b:0:b0:7fa:f76:c7b3 with SMTP id
 6a1803df08f44-87c2055e7e7mr26145206d6.4.1760646493833; 
 Thu, 16 Oct 2025 13:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpk57PW6D4X9WvX0IuDMAZMivkwW+o3AGRH6DJ4n7HhCB9tGFPseesGUyd7bxpTv8ZD0cRrg==
X-Received: by 2002:ad4:5f4b:0:b0:7fa:f76:c7b3 with SMTP id
 6a1803df08f44-87c2055e7e7mr26144826d6.4.1760646493302; 
 Thu, 16 Oct 2025 13:28:13 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87c0121c043sm46918946d6.14.2025.10.16.13.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 13:28:12 -0700 (PDT)
Date: Thu, 16 Oct 2025 16:28:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 mst@redhat.com, jasowang@redhat.com, farosas@suse.de,
 sw@weilnetz.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 michael.roth@amd.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: Re: [PATCH v8 16/19] qapi: introduce backend-transfer migration
 parameter
Message-ID: <aPFVWi1pwxS8yGay@x1.local>
References: <aO_ll4Lf0bq6vgdm@x1.local>
 <3b9f1da4-6264-45d4-ade1-a6273cc6fa1e@yandex-team.ru>
 <aO_--QWDJO7iOhR4@x1.local>
 <8c575b3a-7d1f-446d-8f6d-4b2e4b851731@yandex-team.ru>
 <aPCtkB-GvFNuqlHn@redhat.com>
 <29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru>
 <aPE8Oo5D3oesB7sV@x1.local> <aPE-vmyg1mLDO4pf@redhat.com>
 <aPFHl3VWV0pCmzd1@x1.local> <aPFOHjl5BoWEMqSL@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPFOHjl5BoWEMqSL@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 16, 2025 at 08:57:18PM +0100, Daniel P. Berrangé wrote:
> Errm, machine types apply to devices, but this is about transferring
> backends which are outside the scope of machine types. 

Ah.. I didn't notice that net backends are not inherited by default from
qdev, hence not applicable to machine type properties.

Is it possible we enable it somehow, so that backends can have compat
properties similarly to frontends?

If we go with a list of devices in the migration parameters, to me it'll
only be a way to workaround the missing of such capability of net backends.
Meanwhile, the admin will need to manage the list of devices even if the
admin doesn't really needed to, IMHO.

Thanks,

-- 
Peter Xu


