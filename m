Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69403CD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRWoP-0007lr-84; Mon, 25 May 2026 11:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wRWoN-0007lG-69
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:01:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wRWoL-0006qW-8z
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779721303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GEsfgL5SYs1mBjoNRUpqZyHvO6l/bEjT+Nx6kXjZPbQ=;
 b=O2d5OHT/eoGS9nNZ1ptM3XtxG8wx3EF7t2y89xqdtQW0oI3hm3tnzAC68bLo+XwJbMloOL
 ThD8gkxWVCcxs2Xjxz6bvMnjTR0/cXPcyU50qYNipXRdbsE3fOjd+zAib+zIMDNUx7eATy
 +1gpYq7e6lwDrt3hCdZJO4PYwfHm8bo=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-S4nSuGXwOtafZn7MCbDv1A-1; Mon, 25 May 2026 11:01:42 -0400
X-MC-Unique: S4nSuGXwOtafZn7MCbDv1A-1
X-Mimecast-MFC-AGG-ID: S4nSuGXwOtafZn7MCbDv1A_1779721301
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7e54519e2e0so2032546a34.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779721301; x=1780326101; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GEsfgL5SYs1mBjoNRUpqZyHvO6l/bEjT+Nx6kXjZPbQ=;
 b=jtb8Dmm3NdwQNsHBA7d2cQQsjXaa4C5E6535JUkiBU+SY15IWr9GqzwsvmLjCYktl5
 NFfTtnJ64m4bSCm0oELH9S1jqtL7xBLwfzsmsbanZ1T+yhBpPY70T6mTw75+5FG3+Y6t
 P7H6dQDmCzNMz75rJ3YPwNcDyVZKKywCrUD7MvZ8OLdEXQJzh0OuQn5ThiFx5Z3EujxK
 62WrOOWeO0owrTG9XCJjwVBlSx5J5/NH1GVhXSJ89HGVtkKewq9A/xwO2asBr+ViCxdd
 FPjLwKAx/OLQ452YdQHBe1nIXLohTvu9wO3tDc8Klx6NerrrZxBsMRf+yth09HFPCBQN
 fSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779721301; x=1780326101;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GEsfgL5SYs1mBjoNRUpqZyHvO6l/bEjT+Nx6kXjZPbQ=;
 b=PK1NLC+tfuFDxBCZgd/DfonaAEHcbA9Dm/Pmik1vg3Wqm38hIVIKGuJJYnGHFtYIes
 CLcTGSoBn5d4gUi0jmdaZi1A9cRAPp3j8JCVsDtobgab2DFcM+v+f6waexCzRXgMsrdv
 mCQwRa3M9lHydZmojr2EiTbHZuMLrUxf49/tPv4Tob0r5dkYGn2I2q/cszdylPocMK/i
 HTH6z54WF7Tf+d9htT6xjKH3SaKTy4M/Z/btUnwHI2MbE6gZJh4oKoHb/lzFBr+6TG3P
 LjlPcIpNZoBfHeK/X0dQ79A449ucHNRMN4iS4PmTphpG6kEnecmqD8dArAIqbHE+EV7h
 gb8w==
X-Gm-Message-State: AOJu0YwzsJxvESOy7cL7zmyWRoYbAmFYuShf7a1jaL76tTa65xVOlEtf
 Q3GAENPz417lcxVDlACgi5stMoG/pQPz2uVNBVwA/UJaZOiUdvKrdh727d3HJkindAMTY+YT94t
 yp+LdaNwhM6f9EdlKvS3G0DPnM9Hs5EbVP/qvuwlWSqysU4NAWwqooDJU
X-Gm-Gg: Acq92OF5qQ5D3a6RhHTXzMz7sdZFTOBC7TtQKa+JS//Q/kr2SO35zJF2BFrF+vKg4UJ
 tfuslTCwrCtO6HcWWyBw8kasos1FvSILjzfa2HwLLk72s6FvXBPH2nO+s4RqsChSj4cpXE84e4E
 x/FUcrxempWrWseVXQSXgg94TdZIZJG1jWdPC8r2HTNkRAxyY+ePsHgcpvFWdtysLGwW/5Q7sJP
 8yTp4kwGiIYS9XAmWboJlid5Bf/LPWFB+5CWc0JhxX4Dde1Y8PUn4U4T3Ns+24TTtsDpp6ap3vL
 OpkfHtO6q5wRJqa2zlDDj24jZHY/DijzHOTM3w35o8FRp5P8KExwQumvX1WVq21JhZBBQgitVUN
 lVhCOqQU2a4q+hnVRcAyxe7X5evPlUYkCSBIjH7CV06P7/Qw=
X-Received: by 2002:a05:6830:2650:b0:7e5:fb74:bb48 with SMTP id
 46e09a7af769-7e5fec690b0mr8684038a34.3.1779721301094; 
 Mon, 25 May 2026 08:01:41 -0700 (PDT)
X-Received: by 2002:a05:6830:2650:b0:7e5:fb74:bb48 with SMTP id
 46e09a7af769-7e5fec690b0mr8683844a34.3.1779721299857; 
 Mon, 25 May 2026 08:01:39 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc812e269csm111639506d6.25.2026.05.25.08.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:01:37 -0700 (PDT)
Date: Mon, 25 May 2026 11:01:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH 07/14] migration: Make switchover-ack re-usable
Message-ID: <ahRkT19AVwi4SQA9@x1.local>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-8-avihaih@nvidia.com>
 <agy-q-MTVboGUY_G@x1.local>
 <9631bd0e-5c56-490d-a341-4ad4d5ae91a6@nvidia.com>
 <ag8cqIGtAfe80lKW@x1.local>
 <53cca60e-67b0-4ed2-bdae-6ddbaefc1390@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53cca60e-67b0-4ed2-bdae-6ddbaefc1390@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, May 24, 2026 at 09:34:48AM +0300, Avihai Horon wrote:
> Yes I think so.
> 
> We just need to indicate modules that it’s the last query during switchover
> so they can handle it properly.
> Do you think it would be reasonable to add a "bool final" param to
> save_query_pending handler?
> 
> For RAM it will be used to indicate we are running under the BQL (since
> currently save_query_pending runs only outside BQL) and to pass the proper
> last_stage param into migration_bitmap_sync_precopy().
> For VFIO it will indicate we should not do a query precopy info ioctl (which
> is only valid in VFIO precopy states, not while VM is stopped).

Yes, a final boolean sounds reasonable, implying both (1) last sync before
switchover, VM stopped, (2) BQL held.

For VFIO, I double checked the complete() that does not depend on the
precopy_bytes fetched, then it should be fine indeed,

vfio_save_complete_precopy():
    do {
        data_size = vfio_save_block(f, vbasedev->migration);
        if (data_size < 0) {
            return data_size;
        }
    } while (data_size);

It's just werid to see that it doesn't depend on either precopy_bytes or
initial_bytes, even if logically it should.. this will be confusing to
whoever start reading this code.. but I understand not much we can do with
the current kernel API.

Side note: should we still better update these fields to make sure they'll
be zero after migration? That means vfio_update_estimated_pending_data() in
vfio_save_complete_precopy() too, with/without further sanity checks.  That
seems to be missing right now.  I'm not sure if it's intentional.

Thanks,

-- 
Peter Xu


