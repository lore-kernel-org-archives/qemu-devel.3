Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B06FAD3EE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 02:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFjdG-0000uX-UK; Wed, 22 Apr 2026 22:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mtosatti@redhat.com>)
 id 1wFjdD-0000tt-Ip
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:17:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mtosatti@redhat.com>)
 id 1wFjdB-0006pF-ME
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776910647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oeCY+dpSXnU7MGuuRqfWNuZy5fNAS+mdzgx/PM08of8=;
 b=FtPK2Y4D4XX0mr3rjJufCC/zn+VSAAipXlsGGjeiNIvT2G05ck5qshD/g9EwTBtS4Swi/E
 RJigFkvtAtGfbwCB1Ku+4PEF+We0kyk0vG5yMtZmN182VL8fr5e7X1ZZx/pjwuBYRKsG98
 ikUt+5ot7P71jc206qjz3OKtiuwK+SY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-LTmCNRAFMnadNZq0jb3A1g-1; Wed,
 22 Apr 2026 22:17:23 -0400
X-MC-Unique: LTmCNRAFMnadNZq0jb3A1g-1
X-Mimecast-MFC-AGG-ID: LTmCNRAFMnadNZq0jb3A1g_1776910642
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DD061800473; Thu, 23 Apr 2026 02:17:22 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A41AA180047F; Thu, 23 Apr 2026 02:17:21 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
 id 53AE340135049; Wed, 22 Apr 2026 23:16:59 -0300 (-03)
Date: Wed, 22 Apr 2026 23:16:59 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Florian Schmidt <flosch@nutanix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 2/2] Add HvExtCallGetBootZeroedMemory
Message-ID: <aemBG7BJemipU/8I@tpad>
References: <20260112113139.3762156-1-flosch@nutanix.com>
 <20260112113139.3762156-3-flosch@nutanix.com>
 <a28bd807-6e98-4393-a354-b7ed1f7a08ae@redhat.com>
 <f878fd12-17bc-4249-beca-cd134bb93d2c@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f878fd12-17bc-4249-beca-cd134bb93d2c@nutanix.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mtosatti@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Apr 16, 2026 at 04:33:20PM +0100, Florian Schmidt wrote:
> Hi Paolo, thank you for your reply!
> 
> On 2026-04-16 13:47, Paolo Bonzini wrote:
> > As discussed on IRC, there are multiple sources of writes and each of
> > them needs to be tracked, and we can say that any write potentially
> > makes the page nonzero.
> > 
> > But as far as QEMU is concerned you could indeed add a fourth dirty
> > memory bitmap, DIRTY_MEMORY_NONZERO, and turn it off after the first
> > call to the hypercall (hopefully Windows only calls it once)?
> 
> I'm not sure we can rely on that. I'd have to double-check. Crucially, I'm
> pretty sure some Windows versions may call this more than once, and which of
> those results it then uses is the big question: if it's always the first
> one, we could stop there, return "nothing" as answer for further ones, and
> be good. If it's not the first one... that's a problem, because I don't
> think we want to do this kind of tracking for the whole lifetime of the
> guest?
> 
> 
> > As an alternative to tracking dirty pages in KVM, it would be possible
> > to ask KVM to build a bitmap of pages that were mapped, even at high
> > granularity (e.g. with 32MB you'd fit the bitmap for 1TB of memory in a
> > single page!).  QEMU could use dirty page tracking, and build a
> > combination (NOR) of the bitmap from KVM and QEMU's dirty page bitmap.
> > 
> > QEMU could also do the same high-granularity tracking, but that leaves
> > out other sources of writes like VFIO or vhost, both of which probably
> > matter to Nutanix :) and which would be stuck with 4k-granularity dirty
> > page tracking.
> 
> Are you thinking of creating a new KVM ioctl that would do that for us?
> That's possible, but... isn't good old mincore enough in this case, since
> qemu knows the host-virtual addresses of the guest memory? At the cost of 8
> times as much memory for the (temporary) data structure, since it's a byte
> per page.
> 
> One thing I was wondering about was races. Unless we pause the guest while
> we're scanning the tables, the guest could touch pages as we scan. But: at
> the point the hypercall is invoked by the guest, the guest OS is up by
> definition. So at this point, the guest OS must be aware of any memory that
> is put to use, correct? Even including vfio/vhost stuff, since the buffers
> used to write data into the guest would have been set aside for that purpose
> by the guest. So even if we overestimate and announce some pages as
> pre-zeroed, that shouldn't matter if the guest OS already handed them out
> for some usage (and pre-zeroed them in the meantime). What we really care
> about is not announcing any pages as pre-zeroed that are in fact dirty,
> *and* that the guest OS does not realise were ever dirtied.
> 
> ... Famous last words and I'm not 100% sure, I appreciate any thoughts on
> this.
> 
> Cheers,
> Florian
> 

Two definitions. The first one:

9.4.7 (TLFS PDF):

****************************************************************************************************
Hyper-V allocates zero-filled pages to a VM at creation time. The HvExtCallGetBootZeroedMemory
hypercall can be used to query which GPA pages were zeroed by Hyper-V during creation. 
****************************************************************************************************

This can
prevent the guest memory manager from having to redundantly zero GPA pages, which can reduce
utilization and increase performance.
This is an extended hypercall; its availability must be queried using HvExtCallQueryCapabilities.
Wrapper Interface
HV_STATUS
HvExtCallGetBootZeroedMemory(
__out UINT64 StartGpa,
__out UINT64 PageCount
);
Native Interface
HvExtCallGetBootZeroedMemory
Call Code = 0x8002
 Output Parameters
0 StartGpa (8 bytes)
8 PageCount (8 bytes)
Input Parameters
None.
Output Parameters
StartGpa – the GPA address where the zeroed memory region begins.
PageCount – the number of pages included in the zeroed memory region.

Second definition (the web):

https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercalls/hvextcallgetbootzeroedmemory

The hypercall returns ranges that are known to be zeroed at the time the hypercall is made. Cacheable reads from reported ranges must return all zeroes.

Querying zeroed ranges may allow the virtual machine to avoid zeroing memory that was already zeroed by the hypervisor.

Ranges can include memory that don’t exist and can overlap. The hypervisor should attempt to report "best" / biggest zeroed ranges earlier in the list for optimal performance

====

If qemu uses mmap(MAP_ANONYMOUS), can you return pages which have not
yet been mmaped?
                                                                                              
You can inspect /proc/<pid>/pagemap to find which virtual pages within the mmap region have no physical page backing (i.e., never been written to, still zero-fill-on-demand).                
                                                                                                                                                                                                
Alternatively, /proc/<pid>/smaps gives a per-VMA summary — but for fine-grained per-page resolution within a single large VMA, pagemap is the tool:                                           
                                                                                                                                                                                                
  // For each page in the region, read the 8-byte pagemap entry:                                                                                                                                
  int fd = open("/proc/<pid>/pagemap", O_RDONLY);                                                                                                                                               
  uint64_t entry;                                                                                                                                                                               
  for (addr = start; addr < end; addr += PAGE_SIZE) {                                                                                                                                           
      pread(fd, &entry, 8, (addr / PAGE_SIZE) * 8);                                                                                                                                             
      bool present = entry & (1ULL << 63);  // bit 63 = page present                                                                                                                            
      bool swapped = entry & (1ULL << 62);  // bit 62 = swapped                                                                                                                                 
      if (!present && !swapped) {                                                                                                                                                               
          // Page never faulted in — still unallocated (zero-fill-on-demand)                                                                                                                    
      }                                                                                                                                                                                         
  }                                                

I suppose the OS is responsible for handling races ?

Or rather, Windows assumes nothing has visibility to such memory regions
other than CPUs (which it controls).



