Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEE4C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 18:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNcBG-0001aj-8e; Fri, 06 Jun 2025 14:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNcBE-0001aa-83
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 14:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNcBB-0001VQ-4f
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 14:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749235955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bn9Jf6xH+0pQpdnInWVsMZBNdWd8BOISDCqRTZOVrmc=;
 b=GC0DsgXPj+qCd0/jFIgZpW5FaBiDInEcUYVHevrNalkGUCWBg24EgpjfOyf5YweEw2fXEn
 R6215LSPR0S5RScqOKj8hAwwxip5pEBOZf2ynYVfGqqgupSVSmWMaQBbgvovfYAaLjeUz1
 pL1Q1hG8RV0wYLZGdeeF2d8PxJkYEf8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-fpTWQI_HNEu9CCOynYhRZQ-1; Fri, 06 Jun 2025 14:52:33 -0400
X-MC-Unique: fpTWQI_HNEu9CCOynYhRZQ-1
X-Mimecast-MFC-AGG-ID: fpTWQI_HNEu9CCOynYhRZQ_1749235953
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6fac4b26c69so22872796d6.3
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 11:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749235953; x=1749840753;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bn9Jf6xH+0pQpdnInWVsMZBNdWd8BOISDCqRTZOVrmc=;
 b=sNEITZHBUZmnjb34jjt49ZetHXgLnbni7ZlAAk2HiH5yvt4fiSdiHO8dTiTuUqQuEq
 QC/CkxSMh5TntyXGdcEYi5bhOCia8r1dnTUEbMwuIZpKclvt3LcUxrC2JrAmyWbjzDdh
 U9QrCMXuNFPbJ1OPqlQqeMBWKlXKi+9om7MAAIO8dc6rZDpD26nB4cfKusmvfSWfWwGM
 9KiJy8bbv4vXkAoO6070Qnc1XdojQl9e1WELM1zBQM1HDKetqcZj4meDSgX25Equ7ubT
 12EKbLbFzAjk5Uk1xDyO+W8URUfv/o6vMW2fneJZiHk04O2lFPpNL4iZzybn4X8JIF18
 Xv+A==
X-Gm-Message-State: AOJu0Yz3/gjduwH9MDG7VLuW+m8WrzlyCwRgUbs166fsHbQqwnGNbbQA
 PlyoX/v/2m1vpJJOohCBCUM+dL9C1TCZu3WuIudDC2uBDhyDkOVpLDDhed9JVKCzIYu8DeTlvan
 4RBh439BqdWnmeciTVk6jreyimPtfO2hp1sCDlfRzAkmcHfEs8vxzc+6C
X-Gm-Gg: ASbGncur3CyOf5X2ibXjsZ/vFLDuYAWxuSJ6tyFiiDtOcR1y5gS+3aL2GbgUrZG7Lj3
 /iQ2WY2gUqdJhBDysTOcYsIV4sQBqnA9XGzLaU99+cBvlLMrmSCJycNjZmrVpUFXe1JvHdmY0Pv
 oarJL1V/OJWi98SGFJqH1qysUf51oSspQW+RJ7e+yW2SaqFYPZyho2+Uzx3X7eW7t7BqS25nqXK
 RKQFmLaO5jf3lF6zEwNEFg8p4CcHpUJeF5ok4a1W8JxrYxBFeCNz/5Eaqs+S+O2F7q6zs2f3weT
 q/BrieA0jYtBMg==
X-Received: by 2002:a05:6214:194d:b0:6fa:c8c7:82f7 with SMTP id
 6a1803df08f44-6fb08f5bcd7mr65560476d6.20.1749235952816; 
 Fri, 06 Jun 2025 11:52:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESCn5/1nrHAAN12BSILCXmfToSEpPtyttZYns1f557eodRtRKaeUQ59oYWXAsuDJZmtdrjjQ==
X-Received: by 2002:a05:6214:194d:b0:6fa:c8c7:82f7 with SMTP id
 6a1803df08f44-6fb08f5bcd7mr65560216d6.20.1749235952530; 
 Fri, 06 Jun 2025 11:52:32 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09b2a090sm14994446d6.98.2025.06.06.11.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 11:52:31 -0700 (PDT)
Date: Fri, 6 Jun 2025 14:52:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 14/21] migration: Cleanup hmp_info_migrate_parameters
Message-ID: <aEM47QLg6a-mlzWK@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-15-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603013810.4772-15-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Jun 02, 2025 at 10:38:03PM -0300, Fabiano Rosas wrote:
> Do a cleanup of hmp_info_migrate_parameters() before adding more lines
> into it:
> 
> - Make sure every parameter asserts that the has_* field is
>   set. qmp_query_migrate_parameters should have set them all.
> 
> - Remove the if (params), qmp_query_migrate_parameters never returns
>   NULL.
> 
> - Add a macro to encapsulate boilerplate.
> 
> - Line breaks for legibility.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


