Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35E4CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 17:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0kfB-0008Ha-Sk; Mon, 22 Sep 2025 13:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v0kep-0008Gh-7K
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 13:48:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v0keh-0003lW-JO
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 13:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758563324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TJ35E65PR27qx/1Ro3iqkhsphf+6rTgT6LmxHttk0AE=;
 b=Ffz/ycrjKQ/2pQCQtjSl0RQ3L9uaj2uU9IpQCzLqr1GTTNRFiS95SxKuum2GXEdl9OOlps
 ti01OF2zj4wUg59K4vzqqsNwa7EPRBANUPxcpLsvZroSDD4WDGZF/SraZp1gKm4FcB6KYj
 FyXy3cApsTxmCY4lFjnD2nL53hrq9YQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-xbooge24PSuM3qfxOoDKfw-1; Mon, 22 Sep 2025 13:48:42 -0400
X-MC-Unique: xbooge24PSuM3qfxOoDKfw-1
X-Mimecast-MFC-AGG-ID: xbooge24PSuM3qfxOoDKfw_1758563322
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-79a3c16b2adso46061816d6.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 10:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758563322; x=1759168122;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJ35E65PR27qx/1Ro3iqkhsphf+6rTgT6LmxHttk0AE=;
 b=bsfoofyUh9PlGqQQdomwmoxZj1ZXgCQ+N+F8yGT9uXqVghdyYpwDAp6c8EwtVkHEij
 m4FcwV9UheDAzupPsfm+p45GCA0Q20olCxZA4g5djREgpFSpm6QHkDtzn41NPxDV6M2Z
 ZYhiEQHH5tQsr/shQUvGOtNsV1BBT2jlz+2cEI80BwQmCmgutT+iWV/XSdnCDLdgrBNr
 PnjH8e3lkKgkjG2sWBNyIs9or+SVELFmLqGadQxBdzkKokzHy8KEn07FcWXVJoGhUhRV
 Qoqnr38nRJ9+TOMEaZC/fkLlwVeAP0/C+sIau49EO0rIHQ3AG1FTTlXZwLVaoeDmOZJ/
 jrIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2iWZ4hgkDSsxXHTOsPJYQEE9T1VhoJ2cKkpnVVkqZ4y3sd7MVl7EF7K6lwerUsepsMnU8XUVEMJxu@nongnu.org
X-Gm-Message-State: AOJu0YyADohJ0pB10VpP8ceD7Jpu7t54GG2cTUX6osGNiKRhobN3ePjo
 g/PSpJUxBFBLz0giHJkv62CWD9XFV+X9FsvoozlUBWWTjfi00hzzrNbMOU/ZeP0hyvO41IZMNHZ
 B3Bjd/L1TyvuMYu1udL/xzYoBp+kjJ24iQCrj8suojhLZNOAHi0j2fZHx
X-Gm-Gg: ASbGncsDuB3AtJ3W7ix5nwYzbLLOm+l/E7kGU6GfKnsAL3Arze07vO0YbRk54dweSRS
 JLtFBY8QmxpYs3xWQLCPUCR4mw6HVZqrL7P33hRkvxAWXLg4lCsgJkbCFiXj1gF4JwDbgj8BzgK
 j7rQRdJvd2aPn+hBQTyPCrh8TyX9qgTEtUICpOTZKoxlVjojmhEBJ50XuszVrFWLwdUEPgAy1UB
 h+CDmZ9uHcl1G/CNxV7wzWNhX5y+dBjdJDgbnZIok5P/rhiVL5KTB1d3QsBrFTUCLhdSAfXnE7d
 MjuQKr/i+TP480FgytUa7lXE8mNxfAEX
X-Received: by 2002:ad4:5766:0:b0:78d:4b58:2eca with SMTP id
 6a1803df08f44-7991312df08mr149091406d6.26.1758563321635; 
 Mon, 22 Sep 2025 10:48:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYKJ0DeYRKswjzg4N/Xcj0oBaoT1ff2mKp7D2Ppi6AikzUaHYsdNVFDJ4kc25TMCmAk5cg1Q==
X-Received: by 2002:ad4:5766:0:b0:78d:4b58:2eca with SMTP id
 6a1803df08f44-7991312df08mr149091136d6.26.1758563321174; 
 Mon, 22 Sep 2025 10:48:41 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-796d68804e4sm66922286d6.67.2025.09.22.10.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 10:48:39 -0700 (PDT)
Date: Mon, 22 Sep 2025 13:48:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org,
 Jiri Denemark <jdenemar@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 3/4] migration: Refactor incoming cleanup into
 migration_incoming_finish()
Message-ID: <aNGL9pddTO67cUW-@x1.local>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-4-jmarcin@redhat.com>
 <87plbmtmox.fsf@suse.de>
 <luoiumyvzjxtro6bd4vqn5mq6icf2zfic3n6shivb2e3ngkmcl@bz7vzg7xwdiq>
 <aNFwdic2-d_Crctc@x1.local> <877bxqtmga.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877bxqtmga.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 22, 2025 at 02:40:37PM -0300, Fabiano Rosas wrote:
> A while ago we wrapped QEMU BHs with migration_bh_dispatch_bh. The BHs
> don't need to hold or drop MigrationState reference anymore because the
> dispatch callback does it:
> 
> void migration_bh_schedule(QEMUBHFunc *cb, void *opaque)
> {
>     ...
>     object_ref(OBJECT(s));
>     qemu_bh_schedule(bh);
> }
> 
> static void migration_bh_dispatch_bh(void *opaque)
> {
>     ...        
>     migbh->cb(migbh->opaque);
>     object_unref(OBJECT(s));
>     ...
> }

Indeed!  Ignore my comment.. :)

-- 
Peter Xu


