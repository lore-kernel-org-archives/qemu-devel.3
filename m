Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95CAE77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 19:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVxvm-0001wl-A1; Thu, 09 Jan 2025 14:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVxvb-0001sl-6E
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 14:10:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVxvZ-0000hx-Gf
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 14:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736449844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eFtK4QTOEjj3NzBuDpHJtoffvgCLyW0eHHJjE5ejD00=;
 b=DlUP5CPa65XxrvPndqMJJfYDoo4Git4hIoQn1vftRlO/uINilmmPtW5nqb9IpGOPzo88YJ
 cyRNnTkAWxRAMFsqJgcDN6w4WN+BjwIAXjhSfT+XOda086yhZPhxVp7gZSzIDAjmxASVJ7
 KBF3YSBYFebMa6qULwaoj1Bp3NZ6ZVs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-4FsPFNhsO9W1YF1z3bNmLg-1; Thu, 09 Jan 2025 14:10:43 -0500
X-MC-Unique: 4FsPFNhsO9W1YF1z3bNmLg-1
X-Mimecast-MFC-AGG-ID: 4FsPFNhsO9W1YF1z3bNmLg
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d8f51b49e5so23236626d6.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 11:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736449842; x=1737054642;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eFtK4QTOEjj3NzBuDpHJtoffvgCLyW0eHHJjE5ejD00=;
 b=GP91ahCLL/4HbfOG+D3S8mvxCpX7fpc3WfbHGz2YyeIe8rJi+GMJhu4sLQBZ3ZUfhr
 fiRBV9/Efj7P9sQp3qRKuUmTbsOD8cvILRUnisI9hvdbZ03BtwstYRfjTxxMyOfdFR1U
 rNzhK3AYgBMZGcnqSFAPEU2bk9Awh3W8GjXIm0oNHEGk+6+INhQFt8VsMcjU8OJgwQH5
 ncdWFyr7EbdriTqKod48Tb0mbI+mc6CFmvUGU5u/OAFXc+MOa6T+/WseoFzKTfU2Y/6y
 S6yFmcv9lRqnzRV7iqcxbbpussdhy2IBXpm8QM/Zmw1tS5JFgiIuGe3gOstlajIyYkFN
 cCww==
X-Gm-Message-State: AOJu0YwSd59iBy+VWhL7djPa+l27+GaVs+tuzJ0B9d8O6clZ9djDD1Hg
 TjvwAoNLSxbJ5YTI9siKwAkHpyhBs4GaRDW8TdJ7el/AUwgpOEuprGq55KCbX5jiPlRy6gkF8a9
 qgUj9JBqsjT9R3GW5RKz3kP2fT4pB8aFrKTOWBzcsYdjvhuYSDS2K
X-Gm-Gg: ASbGnctxFFB36Uqip9kTbqHfmGOKKTTuxKuCD/3nBT0u+Xo6lpVhsPuF1XERk3I579l
 J0hE0HXM4UeBepezb4qULhfaf9Yg98pbygi9aU7bXxrRInQ02A8nIzjktjXQMsJURE5QGXFcBkZ
 5CQKTnjSaqBi6GeNe+hm/W+oyAwLPLd+NbY5C/jCuSX2Gg71e79Qw4z4uOu5WmJY6OOAK1M81CT
 3F1bwo2IzGCHU48tBM5hiVVm0La1QLtH5LTMIVe7JABq94ouhNa46VUubpF0I5uIoSPE9aNolws
 M1SHgk3dsL01AuA83g==
X-Received: by 2002:a05:6214:5097:b0:6d8:d79c:1cb2 with SMTP id
 6a1803df08f44-6df9b1f4714mr132321246d6.21.1736449842538; 
 Thu, 09 Jan 2025 11:10:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlGFy4HHwWuQCXm69nt4D5U/wzPU1dRAEH9sx8LQHulYPJQyqUYM6FeBFhECCpWw3ce4HacQ==
X-Received: by 2002:a05:6214:5097:b0:6d8:d79c:1cb2 with SMTP id
 6a1803df08f44-6df9b1f4714mr132320996d6.21.1736449842227; 
 Thu, 09 Jan 2025 11:10:42 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad89f1desm1382976d6.48.2025.01.09.11.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 11:10:41 -0800 (PST)
Date: Thu, 9 Jan 2025 14:10:40 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 6/7] migration: Fix arrays of pointers in JSON writer
Message-ID: <Z4AfMFohWV_QNdbP@x1n>
References: <20250109185249.23952-1-farosas@suse.de>
 <20250109185249.23952-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109185249.23952-7-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Jan 09, 2025 at 03:52:48PM -0300, Fabiano Rosas wrote:
> Currently, if an array of pointers contains a NULL pointer, that
> pointer will be encoded as '0' in the stream. Since the JSON writer
> doesn't define a "pointer" type, that '0' will now be an uint8, which
> is different from the original type being pointed to, e.g. struct.
> 
> (we're further calling uint8 "nullptr", but that's irrelevant to the
> issue)
> 
> That mixed-type array shouldn't be compressed, otherwise data is lost
> as the code currently makes the whole array have the type of the first
> element:
> 
> css = {NULL, NULL, ..., 0x5555568a7940, NULL};
> 
> {"name": "s390_css", "instance_id": 0, "vmsd_name": "s390_css",
>  "version": 1, "fields": [
>     ...,
>     {"name": "css", "array_len": 256, "type": "nullptr", "size": 1},
>     ...,
> ]}
> 
> In the above, the valid pointer at position 254 got lost among the
> compressed array of nullptr.
> 
> While we could disable the array compression when a NULL pointer is
> found, the JSON part of the stream still makes part of downtime, so we
> should avoid writing unecessary bytes to it.
> 
> Keep the array compression in place, but if NULL and non-NULL pointers
> are mixed break the array into several type-contiguous pieces :
> 
> css = {NULL, NULL, ..., 0x5555568a7940, NULL};
> 
> {"name": "s390_css", "instance_id": 0, "vmsd_name": "s390_css",
>  "version": 1, "fields": [
>      ...,
>      {"name": "css", "array_len": 254, "type": "nullptr", "size": 1},
>      {"name": "css", "type": "struct", "struct": {"vmsd_name": "s390_css_img", ... }, "size": 768},
>      {"name": "css", "type": "nullptr", "size": 1},
>      ...,
> ]}
> 
> Now each type-discontiguous region will become a new JSON entry. The
> reader should interpret this as a concatenation of values, all part of
> the same field.
> 
> Parsing the JSON with analyze-script.py now shows the proper data
> being pointed to at the places where the pointer is valid and
> "nullptr" where there's NULL:
> 
> "s390_css (14)": {
>     ...
>     "css": [
>         "nullptr",
>         "nullptr",
>         ...
>         "nullptr",
>         {
>             "chpids": [
>             {
>                 "in_use": "0x00",
>                 "type": "0x00",
>                 "is_virtual": "0x00"
>             },
>             ...
>             ]
>         },
>         "nullptr",
>     }
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


