Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CC8E77199
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 20:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUtcv-0003is-Fh; Mon, 06 Jan 2025 15:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tUtct-0003hy-EA
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 15:23:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tUtcp-0005ZP-Bd
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 15:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736194977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=859HPKiqb8IAcC+jVRnLlw8kYxsQC5X9UClO3gcPRW4=;
 b=OB5N8ZgvAgp3NRrabpheZgn43OO6AAIj++ngKAEDHthCYM6RMz+O2Jz5m/nKsKvN5/l0du
 6m6gSqw2C/oRMx6s6HkNJkdnIWAy9bvJzam++wkKIB5U4wDWWJr48ahk94Xz02QhpAelFv
 dJejKvTvQZX0f1JNdh1qTvj+TJuhePI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-AtW6JgvPM_6sr1OgzCcTrw-1; Mon, 06 Jan 2025 15:22:54 -0500
X-MC-Unique: AtW6JgvPM_6sr1OgzCcTrw-1
X-Mimecast-MFC-AGG-ID: AtW6JgvPM_6sr1OgzCcTrw
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d8eb5ea994so171858876d6.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 12:22:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736194973; x=1736799773;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=859HPKiqb8IAcC+jVRnLlw8kYxsQC5X9UClO3gcPRW4=;
 b=CO7fWhxGYoSxvFeJNbEagKrH76OqTsTXKz1NHUcXd2gpn+AvVIqVsKEkWF1z+oSjBM
 o8K7YBop/jRIZt8WHF6QKF6wDNyIninA1X4s0KF6FrDvQMYX2A2deS7KOdgUwuyGwvpl
 PuhGpoAeoIrW9OdjRIbr5plovKNPglcA66LPoc8vozwpEhYQR9YWx70uKVqv3NOARZ7y
 SJQO0D9osIT6fMXnZWgVVJhh9IHz97F1Bb0BnsBngsr5DVDjFPX3TGw0ZcUH7KDdClMS
 5/mg2GGoL3c84c18Od3gPljJMHqEafjDXn4uTJSi5yP0614skl437D5Pgd34tzZOTSCU
 KXzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL+74N3mEdCseLivf2gXUc2L6F3djgybe4scC8Q1xxhk507rXamJBVndfwc8zN5GreeR9pxW57Bqfl@nongnu.org
X-Gm-Message-State: AOJu0YxYfEqj18ef66fBsA1oTXHPD/kW4EQNl+7KMJZzaJJUFBNhr4ug
 Mf9ihFi4LIvYBepTeO5v9G8utWItdeF7zpqMtatWSZj7lY/RaEDwLzYp1v84w+30yrhn8CQ/EBh
 OBbYtokagFgCjc5E+Vs5oUysrTLZwvJDQrEriN7WeXHQfIT4X5S1e
X-Gm-Gg: ASbGnctuYRoTH8YlnI5OJAAl4FELux32/IQoNmFuQ8gfs0BXObFJXA5T2EWhr3fQHUD
 eZShMdKF8HEYZxZG1Vgz6A64zti3M5BnUUtbT5r+oeVUvwFgFgs+XtZku1tOYXySqdUfeRXkJ5+
 gdegcvToVHU+wgGUek0MYxXxjvTw6svE22ImfGTOrdoOx98OuEp8wxoUGmyjZHNEy99O083j557
 hrEsUYzFUpskqz9fJjYkD541Y+v265MiFX5WsedNPTrZThfAj2FOAQ4YTD/2h0i65wnDpQ8D6v0
 I4eNHGjWjCMcKTpgqg==
X-Received: by 2002:a05:6214:260b:b0:6d4:2646:108a with SMTP id
 6a1803df08f44-6dd23329655mr998440386d6.12.1736194973453; 
 Mon, 06 Jan 2025 12:22:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvgeeA8eadZKPRtwZ7FakRMrESyMfhQQGMxDrP6txicb4SBlo8ytEBx9kVtyyakyAlZU80/Q==
X-Received: by 2002:a05:6214:260b:b0:6d4:2646:108a with SMTP id
 6a1803df08f44-6dd23329655mr998440116d6.12.1736194973175; 
 Mon, 06 Jan 2025 12:22:53 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180ea82fsm173774956d6.26.2025.01.06.12.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 12:22:52 -0800 (PST)
Date: Mon, 6 Jan 2025 15:22:49 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 00/17] Migration patches for 2024-12-17
Message-ID: <Z3w7mSc1XEH8N0IG@x1n>
References: <20241219123213.GA692742@fedora> <87zfkrtsgt.fsf@suse.de>
 <Z2WbSZkEGSnA-BX9@x1n>
 <e5199fbb-e16e-4df0-a93d-5c0eecdc1ec7@redhat.com>
 <874j2f92cn.fsf@suse.de>
 <CAJSP0QVxQf4neUewBha9f=n+6-f2eTD_o5f7v+1R2Wm2y07paA@mail.gmail.com>
 <87sepz7guf.fsf@suse.de> <87pll37cin.fsf@suse.de>
 <Z3wk4GRH6E4kfNma@x1n> <87ldvn7nju.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ldvn7nju.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 06, 2025 at 04:24:53PM -0300, Fabiano Rosas wrote:
> Here's the fix for the pre-existing issue in the script:

For this patch:

> 
> -- 8< --
> From 5bcad03aad85556a7b72f79d3574e246a99432c3 Mon Sep 17 00:00:00 2001
> From: Fabiano Rosas <farosas@suse.de>
> Date: Mon, 6 Jan 2025 15:05:31 -0300
> Subject: [PATCH 1/2] migration: Fix parsing of s390 stream
> 
> The parsing for the S390StorageAttributes section is currently leaving
> an unconsumed token that is later interpreted by the generic code as
> QEMU_VM_EOF, cutting the parsing short.

Better mention why it can be intepreted as QEMU_VM_EOF, especially s390's
tag is 8 bytes while QEMU's EOF is 1 byte.. that confused me. :)

> 
> The migration will issue a STATTR_FLAG_DONE between iterations, but
> there's a final STATTR_FLAG_EOS at .save_complete.
> 
> Fixes: 81c2c9dd5d ("tests/qtest/migration-test: Fix analyze-migration.py for s390x")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  scripts/analyze-migration.py | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> index f2457b1dde..2a2160cbf7 100755
> --- a/scripts/analyze-migration.py
> +++ b/scripts/analyze-migration.py
> @@ -65,6 +65,9 @@ def readvar(self, size = None):
>      def tell(self):
>          return self.file.tell()
>  
> +    def seek(self, a, b):
> +        return self.file.seek(a, b)
> +
>      # The VMSD description is at the end of the file, after EOF. Look for
>      # the last NULL byte, then for the beginning brace of JSON.
>      def read_migration_debug_json(self):
> @@ -272,11 +275,24 @@ def __init__(self, file, version_id, device, section_key):
>          self.section_key = section_key
>  
>      def read(self):
> +        pos = 0
>          while True:
>              addr_flags = self.file.read64()
>              flags = addr_flags & 0xfff
> -            if (flags & (self.STATTR_FLAG_DONE | self.STATTR_FLAG_EOS)):
> +
> +            if flags & self.STATTR_FLAG_DONE:
> +                pos = self.file.tell()
> +                continue
> +            elif flags & self.STATTR_FLAG_EOS:
>                  return
> +            else:
> +                # No EOS came after DONE, that's OK, but rewind the
> +                # stream because this is not our data.
> +                if pos:
> +                    self.file.seek(pos, 0)

Nit: use io.SEEK_SET.

> +                    return
> +                raise Exception("Unknown flags %x", flags)
> +
>              if (flags & self.STATTR_FLAG_ERROR):
>                  raise Exception("Error in migration stream")
>              count = self.file.read64()

With above:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


