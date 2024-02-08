Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30888C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 05:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXxL4-0004Eh-6G; Thu, 08 Feb 2024 00:52:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXxL2-0004E7-VT
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 00:52:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXxKz-00061T-7F
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 00:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707371560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9S34l4b7grSybama13dyEQiXQPJbIDLTCsmA5XrHNUA=;
 b=KoJSHG7Vf68eI82CtFdqZZdTPrkHbSBnjmFT8/UTc4KRlXAQxzyj+Lj9QjYvbf0N4McPn3
 oMMeEToYnQVxGIhUp8Z5CjhX8nWq5hd66LdOz3jiRZFXGh4TTmOATJCvKf4VGHx5TSC5Xh
 ZRGk4kdPtagLInuDOmgd+4hx4hYrHWg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62--9kz_5q7OYC8WfUHZwoJsw-1; Thu, 08 Feb 2024 00:52:39 -0500
X-MC-Unique: -9kz_5q7OYC8WfUHZwoJsw-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1d9bd986bd5so120205ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 21:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707371557; x=1707976357;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9S34l4b7grSybama13dyEQiXQPJbIDLTCsmA5XrHNUA=;
 b=MQsrbOFEpZ24Xlj6EWr8VYjGcVEngxmtXqsfdfmnVP3vWgFN91KSL6mQpCmyabn8Of
 Ya538W54J8DXReLRlNYVOIOZL3wvJjKP9S1ZA9pYudoxjQOv5tOiK78Iy3yhs31pne77
 +NevFaWLsqNhbS7Uf9kkW3A5Oj7TCyzvYbAVb1m78DAXh0gIni1ZnaBTSfjyxd089Sn9
 MM/jhvplZbqxj355g/3aE8GhT7Ar/Ew+UgdFmQMe453FzvaDav/AjZH9GbgXwISIy3ps
 Jtwpk/aB6x37iIPzmub9FQKwsTVMyNz1I0upbQiG/FLibz+k83Dz/49Ml+daNxNFoDV1
 faUw==
X-Gm-Message-State: AOJu0YzOA9TeadSUoUuzpyNFLXTtO4iaz8HTqcEcF8AyRzehH4FZHHoG
 c0wX+Q11gSan5FvlR4JKVo5Q7sGKGCcWQ6cr2QwvvZABiGCtMIAfuG6GM00zApeXj/vuIabUqe7
 Sll23Bug0lCvI/FjDNA9D3Ogrpk1oy0LSSCLv/+AHl9R3YGL+zSeYMC7NKSU+
X-Received: by 2002:a17:902:ee89:b0:1d9:61ef:1876 with SMTP id
 a9-20020a170902ee8900b001d961ef1876mr8221270pld.1.1707371557626; 
 Wed, 07 Feb 2024 21:52:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTDO2zXmdDpBgL8QoAS5ghAPbGLKhwzFTMKip9/e+32ECVSQZaPNISJFLJjTp5cG8qqZ2uhA==
X-Received: by 2002:a17:902:ee89:b0:1d9:61ef:1876 with SMTP id
 a9-20020a170902ee8900b001d961ef1876mr8221260pld.1.1707371557340; 
 Wed, 07 Feb 2024 21:52:37 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXfwq9/a0X+vdMtc9UNIWgcsT2i7WD+/DWXSULcpOhzkMeIXPECIYRhNQbvlwJD5Ei8xZBDUfxihc85q2KsE2yWKZQ1fCpebVTDjZ/6BgBM5wxSCLUVhT8ENVuj
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 jv11-20020a170903058b00b001d9a146907dsm2478124plb.11.2024.02.07.21.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 21:52:37 -0800 (PST)
Date: Thu, 8 Feb 2024 13:52:32 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 13/14] migration: Use migrate_has_error() in
 close_return_path_on_source()
Message-ID: <ZcRsIAt-FA29yLR7@x1n>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-14-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240207133347.1115903-14-clg@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 07, 2024 at 02:33:46PM +0100, Cédric Le Goater wrote:
> close_return_path_on_source() retrieves the migration error from the
> the QEMUFile '->to_dst_file' to know if a shutdown is required. This
> shutdown is required to exit the return-path thread. However, in
> migrate_fd_cleanup(), '->to_dst_file' is cleaned up before calling
> close_return_path_on_source() and the shutdown is never performed,
> leaving the source and destination waiting for an event to occur.
> 
> Avoid relying on '->to_dst_file' and use migrate_has_error() instead.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


