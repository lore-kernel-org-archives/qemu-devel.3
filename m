Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3CFD711C7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 21:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWLnA-0001gC-9K; Thu, 18 Dec 2025 16:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWLn8-0001fx-Lt
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:44:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWLn7-0004vV-3S
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766094246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f8xFRBmCh2b32DjnoF4eP1jVpA5v6BIE3zd26rP+7YI=;
 b=C72I1kEDC39VuNVuJ/2wT4SZdgR5bwei+gLjngI+BHeE/UQschgEcweURN6nJIDBz+JgrI
 fZ/rkih6UXt41O8XWIfJFZ4lGWngOCnqaEATuf4IoFmZjE2yOaMV+wYUXZ4H/hjX2ii2B2
 a5otVAYY2L2/K/A1/SlU5eM6W133r80=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-9gPMDXKUNxafayFOsAQpDA-1; Thu, 18 Dec 2025 16:43:26 -0500
X-MC-Unique: 9gPMDXKUNxafayFOsAQpDA-1
X-Mimecast-MFC-AGG-ID: 9gPMDXKUNxafayFOsAQpDA_1766094200
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-88888397482so29092476d6.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 13:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766094198; x=1766698998; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f8xFRBmCh2b32DjnoF4eP1jVpA5v6BIE3zd26rP+7YI=;
 b=KZkdIgwDC1JDZMUCThgvZH3k2MEVs1jAZL5YJ6s6w9ZzOTS2zH/Lo9KCCtjAncNa8L
 2uQV25TrrVs/50enYX/c+XWuPwxAzxa0AxMcaJrVyg+456eEiRn/fv9LLCLmwdfhp84U
 bg8S9rj+DEQnKv8ZpuHMnly6ZG2Uqj+OBWGbHKFAPJ1m2Ukt0XWxZAVpSgdoasK38ft9
 Kh7+Rl5QSUOdeJ/yMCKlWpsrQD1GaLoerG0VNEfSM+Uxq4vwahfeUEdEIvuXjk1H5I5x
 DcR/y6Qf9m5i4PiKkIHumePiUNaZ5fVEBBPlUDmdSU+dY0BQLgzS+HhJFZL6Irkx8IuT
 Es9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766094198; x=1766698998;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f8xFRBmCh2b32DjnoF4eP1jVpA5v6BIE3zd26rP+7YI=;
 b=DlP+IO+IEjbB+FazG7/AyUoiNsn8XUGT8blGG9f2q5tMP2XyHf4uNu9D3Z2Pr0M3xc
 xrirtQbaz1WhyGK+5P2oj4QeOWvL5YyMwkgmvWHMg5xcLs/ET0F04VIKC9Yrnm+yF/Ye
 hz8UgrcS1rX45SVBlUrBKI1CG2xZH7xdlO+T42SVPOfWDrO59tMqK+bysCYA99soiwrx
 VRNHemG6PagVuk6MMUSEZ4XI88Y0ZP5FuS2a+YnxQO1DfAFFcmQIU3JGBCuQqJylyURS
 zvfMVREGGTfBxHtAsHPavEQPTp16NKi5fv8lV4D2gxbAUhOU2IQcNfKoVlrybFRrwBoj
 Z7/A==
X-Gm-Message-State: AOJu0YzRyxo4misrPHzOO7ujuCIyyk9vxqNToqWMOv3wP5X43BukJzZJ
 KSR5CiFQSapZG+bYvfz8OCtJlrmHRmHT3AucQJupL1gEOm61Hf3uEx8Vf43GtVFkNY50ylATbZj
 z8CFwUYZUdIFL0Pj5KcunSCKzAgyV8TPneGmPo/s0l2avaAwDIJBWfo8JbovIk7Ng
X-Gm-Gg: AY/fxX68Gg0GTrR1XuDMnxYMmquvOngVtX4D7R17f76MgSMW99I82WUdAdjiQ/J75y3
 aC8sf5XGbC9aGD4B0KaXOo2Om1PEJSfTfavjtO8rUptMyFUZope46k5/OoRF4QAlXhfp8MeH3WR
 I7keE7oVQzu8RX75qloyLU8AUx44R/UkBirKegGJ390anHIKrtNfBcmuKEqlfFA5d3uqoV2G+iA
 k2Hmaxo8XogkA6E0QHDLz7N7aTw11QCFodpjOuphKh5pLPe0sAA2xJ/KihlK2sT8vyIxHf3A3B5
 gVvWW8Hg9KpKZfTh3ed+w1qRqC1O5dyKPi+sstdDwTmkDx7rQKNvP194FNS+ZBT6S1yCZ1LpJaA
 WxrQ=
X-Received: by 2002:a05:6214:c6e:b0:77b:2925:a85b with SMTP id
 6a1803df08f44-88d83793335mr21507876d6.44.1766094198556; 
 Thu, 18 Dec 2025 13:43:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHv5RCuc1aO+B55o2YuZfX0Vexx9d/eOiPlkD7Cn/oMHgXjoq7rnikG3szpV9lWVyuINPuJJQ==
X-Received: by 2002:a05:6214:c6e:b0:77b:2925:a85b with SMTP id
 6a1803df08f44-88d83793335mr21507556d6.44.1766094198159; 
 Thu, 18 Dec 2025 13:43:18 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88d969fed73sm4923656d6.15.2025.12.18.13.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 13:43:17 -0800 (PST)
Date: Thu, 18 Dec 2025 16:43:16 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 37/51] tests/qtest/migration: Add new hook with data
Message-ID: <aUR1dMVRQ_9rVx75@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-38-farosas@suse.de>
 <aURQgjrsVhlfu8kr@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aURQgjrsVhlfu8kr@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Thu, Dec 18, 2025 at 02:05:38PM -0500, Peter Xu wrote:
> On Mon, Dec 15, 2025 at 07:00:23PM -0300, Fabiano Rosas wrote:
> > Add a new start hook that takes an opaque pointer so the tests can
> > stop having to nest hook calls.
> 
> I saw that this hook is also removed after the whole series applied.. maybe
> it should be mentioned here.

I guess I read the wrong tree just now... both hooks will be present.

Then IMHO we could have one patch merge them, because start_hook() ones can
ignore the opaque..  Then we can rename start_hook_full() back to
start_hook() (or... just add the opaque since the start into start_hook?).

-- 
Peter Xu


