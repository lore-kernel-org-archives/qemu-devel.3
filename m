Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7528CCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 22:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDrtV-0002iT-PT; Tue, 28 Oct 2025 18:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vDrtS-0002i3-Eg
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 18:10:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vDrtG-0001PF-1t
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 18:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761689400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xxPmWJy8goSvbsAvaDdewY8/5hwNk5ldoU6C5+BL/P8=;
 b=ipBD9YP0ubLYzLnzTURFBlkU17PsYyo2MBIXyDBpvaEeuqu+EdHLpsg7S/694ZuQM1D8jJ
 vfk7GPSg7k87eqAmTHV32lWrNbmFfr32kIhlRgWn2aWp3X1XeB3MvLtLWf0opXw+3XvsGe
 k3LtKJPaYxWRblqkJJikVEtYr4mn2n8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-q6Q1kFl9PEKh__SZXpLbMA-1; Tue, 28 Oct 2025 18:09:59 -0400
X-MC-Unique: q6Q1kFl9PEKh__SZXpLbMA-1
X-Mimecast-MFC-AGG-ID: q6Q1kFl9PEKh__SZXpLbMA_1761689399
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-88f81cf8244so2614867985a.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 15:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761689398; x=1762294198;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxPmWJy8goSvbsAvaDdewY8/5hwNk5ldoU6C5+BL/P8=;
 b=JnAneBEs5t+go0GcdW8+H6v+7mmTnPl1SywREEJotYvp5pWWhnjTDzEbnOaiJ/AsZr
 QaaV840XFDZBZzjVtkeaZrYpLWP/STh9iwnI88Cz/DqXyrshL8wiPDb3FAxoIudSdQYm
 P/sh4Wm15G4v6l6ssxIgztVtWZasiiW9ed2LKN9PNtchPQpE2+JqFt5S6IIqbXbirWrL
 /Y3ESRN/qDPD+sk+/vOv3LfEHcdv4J/iCP5P5w2IGndwccdrGTl78BV57WX3uU/BKghS
 w0FgIK435iDH7SSFTS8jnbQdxrSuO3PqGX9qHyHEUcZtlkGRIOtmk05c6jazo6xUxIuN
 5/Hw==
X-Gm-Message-State: AOJu0YxO6o1lECMKPx15eump5qbF8OkYx+W74S8iRFDlueafvbKtpyme
 S2wlEN8juwF8AOUz/bNLpe5EbX98aoTResngWld2V0y2xM8sE6zuvy7VqafCdwpwRxQLWlP5R2W
 pvnqM9e0Ko7NwiNFoHyGPTAYPMkHwWNaogWbZRO8Ahxfdno1fKlOrtCTOWp2Ea7zn
X-Gm-Gg: ASbGncsK0WFMRrM6zZoNIzJ2Fln/h235GCcCcg6ivptz8IvGG1mTzZ0Ks+xj3NvgJ9C
 J0l+/30/0qzCmHstSj5j8A1/f80M/ZaO3nAsdLZrpDaxsczDVmxN1KmMRQXrZsJh4k0s5Sac4gN
 0/mIyZcgq8kT9A/2WVzDLjN9HIAFUMbcwV4XWyM474WnSlYbzer8r2HPY+JAdUqin2pjm32Kkfv
 poZcu6FVfi4D99yk8Y6+ipkpZ/SL/LwUIuiM3y5y7YnINQ3LxQS/MeMzZKwmmwpp16k/SLlDlnI
 DGg3bdB9pKGeGMUwT0nnooI9iOMCBpVINLTaMMocP1LkGImELEjgJk9aQboLPHiBW/Q=
X-Received: by 2002:a05:620a:4711:b0:88f:dba3:e9c8 with SMTP id
 af79cd13be357-8a8e55c7d78mr128282185a.72.1761689398295; 
 Tue, 28 Oct 2025 15:09:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEivBkIMBLDviAA+oCCIdbLtN/KuyvYK8zu58ZWQ5CQ3Vq7QSZlibBkv0DeNdcOcUCjXFRslA==
X-Received: by 2002:a05:620a:4711:b0:88f:dba3:e9c8 with SMTP id
 af79cd13be357-8a8e55c7d78mr128278585a.72.1761689397759; 
 Tue, 28 Oct 2025 15:09:57 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f25896d52sm910808085a.38.2025.10.28.15.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 15:09:56 -0700 (PDT)
Date: Tue, 28 Oct 2025 18:09:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] memory: Make FlatView root references weak
Message-ID: <aQE_M1qsr78RrQaw@x1.local>
References: <20251027-root-v1-1-ddf92b9058be@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251027-root-v1-1-ddf92b9058be@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Mon, Oct 27, 2025 at 02:56:53PM +0900, Akihiko Odaki wrote:
> docs/devel/memory.rst says "memory_region_ref and memory_region_unref
> are never called on aliases", but these functions are called for
> FlatView roots, which can be aliases.

IMHO the quoted doc was in a special context, where it was talking about
the example of address_space_map() holding adhoc refcounts of a MR, in
which case "memory_region_ref and memory_region_unref are never called on
aliases" was correct..

The full context:

  ...
  If you break this rule, the following situation can happen:
  
  - the memory region's owner had a reference taken via memory_region_ref
    (for example by address_space_map)
  
  - the region is unparented, and has no owner anymore
  
  - when address_space_unmap is called, the reference to the memory region's
    owner is leaked.
  
  There is an exception to the above rule: it is okay to call
  object_unparent at any time for an alias or a container region.  It is
  therefore also okay to create or destroy alias and container regions
  dynamically during a device's lifetime.
  
  This exceptional usage is valid because aliases and containers only help
  QEMU building the guest's memory map; they are never accessed directly.
  memory_region_ref and memory_region_unref are never called on aliases
  or containers, and the above situation then cannot happen.  Exploiting
  this exception is rarely necessary, and therefore it is discouraged,
  but nevertheless it is used in a few places.
  ...

So I can't say the doc is wrong, but maybe it can be at least be clearer on
the scope of that sentence.. indeed.

> 
> This causes object overwrite hazard in pci-bridge. Specifically,
> pci_bridge_region_init() expects that there are no references to
> w->alias_io after object_unparent() is called, allowing it to reuse the
> associated storage. However, if a parent bus still holds a reference to
> the existing object as a FlatView's root, the storage is still in use,
> leading to an overwrite. This hazard can be confirmed by adding the
> following code to pci_bridge_region_init():
> 
> PCIDevice *parent_dev = parent->parent_dev;
> assert(!object_dynamic_cast(OBJECT(parent_dev), TYPE_PCI_BRIDGE) ||
>        PCI_BRIDGE(parent_dev)->as_io.current_map->root != &w->alias_io);

What's interesting is I found PCIBridge.as_io / PCIBridge.as_mem are not
used anywhere..  because it looks like the bridge code uses MRs to operate
rather than address spaces.

Does it mean we can drop the two ASes?  Then if they're the only holder of
the refcounts of these problematic MRs, does it solve the problem too in an
easier way?  Maybe there're other issues you want to fix too with this patch?

> 
> This assertion fails when running:
> meson test -C build qtest-x86_64/bios-tables-test \
>     '--test-args=-p /x86_64/acpi/piix4/pci-hotplug/no_root_hotplug'
> 
> Make the references of FlatView roots "weak" (i.e., remove the
> reference to a root automatically removed when it is finalized) to
> avoid calling memory_region_ref and memory_region_unref and fix the
> hazard with pci-bridge.
> 
> Alternative solutions (like removing the "never called on aliases"
> statement or detailing the exception) were rejected because the alias
> invariant is still relied upon in several parts of the codebase, and
> updating existing code to align with a new condition is non-trivial.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  system/memory.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 8b84661ae36c..08fe5e791224 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -266,7 +266,6 @@ static FlatView *flatview_new(MemoryRegion *mr_root)
>      view = g_new0(FlatView, 1);
>      view->ref = 1;
>      view->root = mr_root;
> -    memory_region_ref(mr_root);
>      trace_flatview_new(view, mr_root);
>  
>      return view;
> @@ -301,7 +300,6 @@ static void flatview_destroy(FlatView *view)
>          memory_region_unref(view->ranges[i].mr);
>      }
>      g_free(view->ranges);
> -    memory_region_unref(view->root);
>      g_free(view);
>  }
>  
> @@ -1796,6 +1794,12 @@ void memory_region_init_iommu(void *_iommu_mr,
>  static void memory_region_finalize(Object *obj)
>  {
>      MemoryRegion *mr = MEMORY_REGION(obj);
> +    gpointer key;
> +    gpointer value;
> +
> +    if (g_hash_table_steal_extended(flat_views, mr, &key, &value)) {
> +        ((FlatView *)value)->root = NULL;
> +    }

This is definitely very tricky.. The translation path (from
AddressSpaceDispatch) indeed looks ok as of now, which doesn't looks at
view->root.. however at least I saw this:

void flatview_unref(FlatView *view)
{
    if (qatomic_fetch_dec(&view->ref) == 1) {
        trace_flatview_destroy_rcu(view, view->root);
        assert(view->root);                            <-------------------
        call_rcu(view, flatview_destroy, rcu);
    }
}

I wonder how it didn't already crash.

The other stupid but working solution is we can always make the 6 aliases
to not be reused, IOW we can always use dynamic MRs considering
pci_bridge_update_mappings() should be rare?

In short, I wished we can fix this with something cleaner, and it's hard to
justify view->root==NULL is fine to be concurrently reset.. So IMHO we
should be very careful justifying this.

Thanks,

>  
>      /*
>       * Each memory region (that can be freed) must have an owner, and it
> 
> ---
> base-commit: 36076d24f04ea9dc3357c0fbe7bb14917375819c
> change-id: 20251024-root-d431450fcbbf
> 
> Best regards,
> --  
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 

-- 
Peter Xu


