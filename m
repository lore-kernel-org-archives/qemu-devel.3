Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041E2C04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwiuI-0002ex-48; Tue, 16 Apr 2024 09:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwiuG-0002eK-2f
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwiuD-0005kn-JB
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713274284;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ay8f3QrmesUuJpr6Xnv/URkLo7BCLLsv36wohgy4hCY=;
 b=Ut5uRPaglBihLjoJ0ROoJSilEQePaNhqKagiXvxYPqTQz1TBCTVYuDE1gK8rsA6LSqvESa
 753P7ii4KX65Xyg9f2kY5RD9j/up8lUOqQWC/wtbjbZqOcgEVW2sUYTIqYQitxPfpJfXPr
 MKyN1dduw9QWzg7126VWVIYInd9njbQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-2Y5RHPC4OSubIcIo7s8UPQ-1; Tue,
 16 Apr 2024 09:31:21 -0400
X-MC-Unique: 2Y5RHPC4OSubIcIo7s8UPQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D05583C0FCAA;
 Tue, 16 Apr 2024 13:31:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.173])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3F1F1BDAA;
 Tue, 16 Apr 2024 13:31:17 +0000 (UTC)
Date: Tue, 16 Apr 2024 14:31:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Roy Hopkins <roy.hopkins@suse.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v2 03/10] backends/confidential-guest-support: Add
 functions to support IGVM
Message-ID: <Zh59n3w5Ijfd2uLs@redhat.com>
References: <cover.1712141833.git.roy.hopkins@suse.com>
 <1dff8015f9f9cf735de21a16e5dba14371c39155.1712141833.git.roy.hopkins@suse.com>
 <c31dcace-92da-4de7-93e6-631120829a75@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c31dcace-92da-4de7-93e6-631120829a75@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 04, 2024 at 10:00:53AM +0200, Philippe Mathieu-Daudé wrote:
> Hi Roy,
> 
> On 3/4/24 13:11, Roy Hopkins wrote:
> > In preparation for supporting the processing of IGVM files to configure
> > guests, this adds a set of functions to ConfidentialGuestSupport
> > allowing configuration of secure virtual machines that can be
> > implemented for each supported isolation platform type such as Intel TDX
> > or AMD SEV-SNP. These functions will be called by IGVM processing code
> > in subsequent patches.
> > 
> > This commit provides a default implementation of the functions that
> > either perform no action or generate a warning or error when they are
> > called. Targets that support ConfidentalGuestSupport should override
> > these implementations.
> > 
> > Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> > ---
> >   backends/confidential-guest-support.c     | 32 ++++++++++
> >   include/exec/confidential-guest-support.h | 74 +++++++++++++++++++++++
> >   2 files changed, 106 insertions(+)
> 
> 
> >   struct ConfidentialGuestSupport {
> >       Object parent;
> > @@ -60,6 +94,46 @@ struct ConfidentialGuestSupport {
> >        */
> >       char *igvm_filename;
> >   #endif
> > +
> > +    /*
> > +     * The following virtual methods need to be implemented by systems that
> > +     * support confidential guests that can be configured with IGVM and are
> > +     * used during processing of the IGVM file with process_igvm().
> > +     */
> > +
> > +    /*
> > +     * Check for to see if this confidential guest supports a particular
> > +     * platform or configuration
> > +     */
> > +    int (*check_support)(ConfidentialGuestPlatformType platform,
> > +                         uint16_t platform_version, uint8_t highest_vtl,
> > +                         uint64_t shared_gpa_boundary);
> > +
> > +    /*
> > +     * Configure part of the state of a guest for a particular set of data, page
> > +     * type and gpa. This can be used for example to pre-populate and measure
> > +     * guest memory contents, define private ranges or set the initial CPU state
> > +     * for one or more CPUs.
> > +     *
> > +     * If memory_type is CGS_PAGE_TYPE_VMSA then ptr points to the initial CPU
> > +     * context for a virtual CPU. The format of the data depends on the type of
> > +     * confidential virtual machine. For example, for SEV-ES ptr will point to a
> > +     * vmcb_save_area structure that should be copied into guest memory at the
> > +     * address specified in gpa. The cpu_index parameter contains the index of
> > +     * the CPU the VMSA applies to.
> > +     */
> > +    int (*set_guest_state)(hwaddr gpa, uint8_t *ptr, uint64_t len,
> > +                           ConfidentialGuestPageType memory_type,
> > +                           uint16_t cpu_index, Error **errp);
> > +
> > +    /*
> > +     * Iterate the system memory map, getting the entry with the given index
> > +     * that can be populated into guest memory.
> > +     *
> > +     * Returns 0 for ok, 1 if the index is out of range and -1 on error.
> > +     */
> > +    int (*get_mem_map_entry)(int index, ConfidentialGuestMemoryMapEntry *entry,
> > +                             Error **errp);
> >   };
> >   typedef struct ConfidentialGuestSupportClass {
> 
> Methods are usually a class field, not an instance one. Any
> reason to diverge from this norm?

Agreed, this should all be against the Class.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


