Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA6AC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 20:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgpXT-00019b-W7; Mon, 06 Jul 2026 16:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wgpXM-0000tP-6u
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:03:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wgpXK-0005ww-8H
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783368204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bjhjqMJyMifKeYAIJJZSEpl1j9+0fJp1t8ThvfMGMOQ=;
 b=YVAvIBgE72YeJ7S+B50CIhA9PRCzm4njR3WfLhphiYKYqEviMPeOYM7cUXr3X1uBn/7Swf
 rwvbVg7SP6YjQMBRmLGUjqnibeNroZeGg4jHAw+yDy4gKaFkxACv2RmnZp8jOLv/yw1OeE
 YYPFhgQcm0XdDQ83V8rHvnwaDup+YTM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-KukQg54CNCOiAjrNnIMTrQ-1; Mon, 06 Jul 2026 16:03:22 -0400
X-MC-Unique: KukQg54CNCOiAjrNnIMTrQ-1
X-Mimecast-MFC-AGG-ID: KukQg54CNCOiAjrNnIMTrQ_1783368202
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ea75996387so71018556d6.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783368202; x=1783973002; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bjhjqMJyMifKeYAIJJZSEpl1j9+0fJp1t8ThvfMGMOQ=;
 b=dPGrxTuyogzWt9j6OES/VLRm9fS1TxjmYFDHwmUnfcHWlXyqO/e7i3KZGM2NB8YrX5
 +XC3Ed5UhFHKPMOD22hl9IS5mITY05p13/3W/JHLflSVEw2yqqT9ICMkOa1Y+ap55if3
 0WTO7YfstFNBT/7A1iL4NoMOFxIiuutbaAtH+87Wr2JUSNsUliUw1ToqWV2/JNEddjjW
 ++COengBiKriNnDPM8kPPB713Q02yNl/mcKuoLTbblLMKc3M+S5+PmRNPvtmRmEjFVbK
 jzrV3QVDhMTq0+gX9s+NO63HAXgDw/ijMI914uH0GaS5dLVGMQXjr0rAl9qconhT8e2b
 +BqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783368202; x=1783973002;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bjhjqMJyMifKeYAIJJZSEpl1j9+0fJp1t8ThvfMGMOQ=;
 b=reudMIHqU/54VbdGdojO21hSs++lEaI03HSL83mxUPn3/kFlUMulQcESoSqkI6LPGD
 h0HYEKcnVOJHl0btMqXfA56CQR33ezKl83tonKmhZCegCX/xdvrvNr0osBo2VP7jqzJp
 R78Lsb2G/Mokx+RwWsxBKx2tInPJav8oY5BGoc+j4Vc6u50KIjvWL3MWoaF+8jj006Sp
 tKxcdqKkYEXb1bQBYmKmpcfPXBECXuVQkfOKY/M5pgTSx6jpnd6DyD1AaV8n5XZYpeUj
 cnkRRZvKlM3pPUaxt37lwQJDknct7JSJO1jLfvZrYx7aGGL9Adtnko/SgJWgryt2JI1y
 dfpQ==
X-Gm-Message-State: AOJu0Ywt4WQ43H6xX+ICgZWW10vXb/DqvDo15qos3IycYThc0u7mHCYz
 H8/o41UlN3tbkLzxp5ROuwWvUaa8YdSqgJODy8wNMk6Cah6DtwMsi6PWaUkMRgU6a79GA4EpbLr
 5FAaKoC5dBPHAo4NAV1oxe5FuXBVGBTKkGvLLySANVRzV8LAt+ZZIYC14
X-Gm-Gg: AfdE7cm4mHhVlhgwWW8072NNjyOcQfJhJnjbOMXzY1kkTDqgBhsPBDVctIOo+fcmVxE
 kzSuaLofefPBXq/P7++dvA9t2eo8654Xu0Yu3jqrj1NYP5zqFPaTrFTwKW9j1ygeskxsySP4qIy
 /ToyHdNH0wLvRGBMTU8Ux3R85ltU4gvQeKWk8nEvFKtzCli+fyHfw5iRRV0y+DccdelVxy6v9Gy
 see6B0F9S/JcxnVC6Y/G3JR7uufE5e6ENfyk01aO7xV4VjC81SmDgfC+epM/+7+Qf6S1pkxoWVL
 p0HWjfu3NFwXXxIY77P7KNx9vycpusqIJ/ZWrri8drQ+BJW0lJUXf29yrmU6zNllx5IbbKEJrCp
 gOIdVR6pBL6ItCOykgsWD58bBwkB3UQpVPGMTFoR7oiO8wy0sNlTwc+ccKbVJPTwOYglkow==
X-Received: by 2002:ad4:5944:0:b0:8cc:f074:95e with SMTP id
 6a1803df08f44-8fcb51e7310mr23694566d6.30.1783368201970; 
 Mon, 06 Jul 2026 13:03:21 -0700 (PDT)
X-Received: by 2002:ad4:5944:0:b0:8cc:f074:95e with SMTP id
 6a1803df08f44-8fcb51e7310mr23694046d6.30.1783368201358; 
 Mon, 06 Jul 2026 13:03:21 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f471814324sm145497966d6.28.2026.07.06.13.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 13:03:20 -0700 (PDT)
Date: Mon, 6 Jul 2026 16:03:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Subject: Re: [RFC PATCH v2 5/7] migration: add RAMBlock field and helper for
 fast snapshot load
Message-ID: <akwKBx-iGCwGZdGd@x1.local>
References: <20260630081940.611092-1-aadeshveer07@gmail.com>
 <20260630081940.611092-6-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630081940.611092-6-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 30, 2026 at 01:49:38PM +0530, Aadeshveer Singh wrote:
> Add pending_bmap field per RAMBlock which is a Bitmap to store
> internal state of which pages have been read by some thread to ensure
> coordination between fault thread and eager load thread.
> 
> Modify parse_ramblock_mapped_ram(), to not load the actual RAMBlocks
> data in postcopy case as that will be loaded by fault thread and eager
> thread after the VM starts running.
> 
> Change ram_load() to use new function ram_should_load_postcopy_pages()
> to decide how to load/read RAM.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> ---
>  include/system/ramblock.h |  6 ++++
>  migration/ram.c           | 59 +++++++++++++++++++++++++++++++++++----
>  2 files changed, 59 insertions(+), 6 deletions(-)
> 
> diff --git a/include/system/ramblock.h b/include/system/ramblock.h
> index 4435f8d55f..83187bf44c 100644
> --- a/include/system/ramblock.h
> +++ b/include/system/ramblock.h
> @@ -60,6 +60,12 @@ struct RAMBlock {
>  
>      /* Bitmap of already received pages.  Only used on destination side. */
>      unsigned long *receivedmap;
> +    /*
> +     * Bitmap for pages that are yet to be read from disk. It is required for
> +     * fault thread and eager thread to keep note of which pages are currently
> +     * being read. Used by fast snapshot load.
> +     */
> +    unsigned long *pending_bmap;
>  
>      /*
>       * bitmap to track already cleared dirty bitmap.  When the bit is
> diff --git a/migration/ram.c b/migration/ram.c
> index 4728f14d73..ffd60b2ac8 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -263,6 +263,18 @@ static void ramblock_file_bmap_init(void)
>      }
>  }
>  
> +static void ramblock_pending_bmap_init(void)
> +{
> +    RAMBlock *rb;
> +
> +    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> +        assert(!rb->pending_bmap);
> +        size_t size = rb->max_length >> qemu_target_page_bits();

IIUC we should always stick with rb->page_size (aka, host page size) here
rather than guest page size.  It's because you want to use that one bit to
serialize the two threads (fault thread, eager thread) when do atomic
test_and_clear, and since UFFDIO_COPY needs to happen at host page size
granule, this needs to match that.

> +        rb->pending_bmap = bitmap_new(size);
> +        bitmap_set(rb->pending_bmap, 0, size);
> +    }
> +}
> +
>  static void ramblock_recv_map_init(void)
>  {
>      RAMBlock *rb;
> @@ -3762,6 +3774,10 @@ static int ram_load_setup(QEMUFile *f, void *opaque, Error **errp)
>      ramblock_recv_map_init();
>      if (migrate_mapped_ram()) {
>          ramblock_file_bmap_init();
> +        if (migrate_postcopy_ram()) {
> +            /* fast snapshot load */
> +            ramblock_pending_bmap_init();
> +        }
>      }
>  
>      return 0;
> @@ -3782,6 +3798,7 @@ static int ram_load_cleanup(void *opaque)
>      RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
>          g_clear_pointer(&rb->receivedmap, g_free);
>          g_clear_pointer(&rb->file_bmap, g_free);
> +        g_clear_pointer(&rb->pending_bmap, g_free);
>      }
>  
>      return 0;
> @@ -4201,9 +4218,12 @@ static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
>          return;
>      }
>  
> -    if (!read_ramblock_mapped_ram(f, block, num_pages, block->file_bmap,
> -                                  errp)) {
> -        return;
> +    if (!migrate_postcopy_ram()) {
> +        /* Do not load RAM during setup for fast snapshot load */
> +        if (!read_ramblock_mapped_ram(f, block, num_pages, block->file_bmap,
> +                                      errp)) {
> +            return;
> +        }
>      }
>  
>      /* Skip pages array */
> @@ -4475,15 +4495,42 @@ static int ram_load_precopy(QEMUFile *f)
>      return ret;
>  }
>  
> +static bool ram_should_load_postcopy_pages(void)
> +{
> +    /* This is pure precopy, we don't need to load pages in postcopy way */
> +    if (!postcopy_is_running()) {
> +        return false;
> +    }
> +
> +    /*
> +     * This is postcopy, but when with mapped-ram, pages are not loaded in the
> +     * migration stream here, but done separately in a thread eagerly reading
> +     * pages from the snapshot.  Here, we only need to read the ram headers,
> +     * reusing the precopy code.
> +     * TODO: when we have separate function to parse RAM headers we should
> +     * switch to that.
> +     */
> +    if (migrate_mapped_ram()) {
> +        return false;
> +    }
> +
> +    /*
> +     * Genuine network postcopy, we will load pages in this current stream and
> +     * they need to be done in postcopy way.
> +     */
> +    return true;
> +}
> +
>  static int ram_load(QEMUFile *f, void *opaque, int version_id)
>  {
>      int ret = 0;
>      static uint64_t seq_iter;
>      /*
>       * If system is running in postcopy mode, page inserts to host memory must
> -     * be atomic
> +     * be atomic. However, fast snapshot load uses the mapped ram precopy like
> +     * path to read block headers and populating bitmaps.
>       */
> -    bool postcopy_running = postcopy_is_running();
> +    bool load_postcopy_pages = ram_should_load_postcopy_pages();
>  
>      seq_iter++;
>  
> @@ -4499,7 +4546,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>       */
>      trace_ram_load_start();
>      WITH_RCU_READ_LOCK_GUARD() {
> -        if (postcopy_running) {
> +        if (load_postcopy_pages) {
>              /*
>               * Note!  Here RAM_CHANNEL_PRECOPY is the precopy channel of
>               * postcopy migration, we have another RAM_CHANNEL_POSTCOPY to
> -- 
> 2.54.0
> 

-- 
Peter Xu


