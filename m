Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCE1C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 14:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZtJX-0004oH-FE; Fri, 02 Aug 2024 10:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junon@oro.sh>) id 1sZtJR-0004Th-TS
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:31:21 -0400
Received: from out-171.mta0.migadu.com ([2001:41d0:1004:224b::ab])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junon@oro.sh>) id 1sZtJP-0000Rr-JO
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:31:21 -0400
Date: Fri, 2 Aug 2024 16:31:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oro.sh; s=key1;
 t=1722609074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZsvysJo1be0NV1KxCW6AvIldiRLHaG2ZyFzKDIJjHfE=;
 b=DwDNXBqe9TfwDShmAkzUlFm3kc7D54u2mjGOuQFz7duGp+esiXq4nKZnkZdgD1swAdK/WY
 JSdzM32VJ0AIM9+w/cDaz0hNooqnLqP5763UUPxIMEJXHnbp3SbL4aUO5eOYxcB0vQsILy
 L9IM0dOJQJEVIULJnr9so4KWWt6t4FQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Josh Junon <junon@oro.sh>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3] qmp: Use unsigned integers for address parameters
Message-ID: <Zqztrp1Yt7L0TKwr@DESKTOP-TBGODF1.localdomain>
References: <20240802140704.13591-1-junon@oro.sh> <87r0b7xb27.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0b7xb27.fsf@pond.sub.org>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::ab;
 envelope-from=junon@oro.sh; helo=out-171.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Fri, Aug 02, 2024 at 04:18:40PM +0200, Markus Armbruster wrote:
> Let's go back to v1's title
> 
>     qmp: Fix higher half vaddrs for [p]memsave
> 
> Josh Junon <junon@oro.sh> writes:
> 
> > Fixes higher-half address parsing for QMP commands
> > `[p]memsave`.
> >
> > Signed-off-by: Josh Junon <junon@oro.sh>
> > ---
> >  qapi/machine.json | 11 +++++++++--
> >  system/cpus.c     | 10 +++++-----
> >  2 files changed, 14 insertions(+), 7 deletions(-)
> >
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index fcfd249e2d..fb618dc99f 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -852,7 +852,11 @@
> >  #     <- { "return": {} }
> >  ##
> >  { 'command': 'memsave',
> > -  'data': {'val': 'int', 'size': 'int', 'filename': 'str', '*cpu-index': 'int'} }
> > +  'data': {
> > +     'val': 'uint64',
> > +     'size': 'size',
> > +     'filename': 'str',
> > +     '*cpu-index': 'int' } }
> >  
> >  ##
> >  # @pmemsave:
> > @@ -878,7 +882,10 @@
> >  #     <- { "return": {} }
> >  ##
> >  { 'command': 'pmemsave',
> > -  'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
> > +  'data': {
> > +    'val': 'uint64',
> > +    'size': 'size',
> > +    'filename': 'str' } }
> >  
> >  ##
> >  # @Memdev:
> > diff --git a/system/cpus.c b/system/cpus.c
> > index 5e3a988a0a..f33e4fbff0 100644
> > --- a/system/cpus.c
> > +++ b/system/cpus.c
> > @@ -792,14 +792,14 @@ int vm_stop_force_state(RunState state)
> >      }
> >  }
> >  
> > -void qmp_memsave(int64_t addr, int64_t size, const char *filename,
> > +void qmp_memsave(uint64_t addr, uint64_t size, const char *filename,
> >                   bool has_cpu, int64_t cpu_index, Error **errp)
> >  {
> >      FILE *f;
> > -    uint32_t l;
> > +    uint64_t l;
> >      CPUState *cpu;
> >      uint8_t buf[1024];
> > -    int64_t orig_addr = addr, orig_size = size;
> > +    uint64_t orig_addr = addr, orig_size = size;
> >  
> >      if (!has_cpu) {
> >          cpu_index = 0;
>        }
>    [...]
>            if (cpu_memory_rw_debug(cpu, addr, buf, l, 0) != 0) {
>                error_setg(errp, "Invalid addr 0x%016" PRIx64 "/size %" PRId64
>                                 " specified", orig_addr, orig_size);
> 
> @size is now unsigned and should be formatted with PRIu64.

Ah yes, missed that one last round. Apologies!

> 
>                goto exit;
>            }
> > @@ -840,11 +840,11 @@ exit:
> >      fclose(f);
> >  }
> >  
> > -void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
> > +void qmp_pmemsave(uint64_t addr, uint64_t size, const char *filename,
> >                    Error **errp)
> >  {
> >      FILE *f;
> > -    uint32_t l;
> > +    uint64_t l;
> >      uint8_t buf[1024];
> >  
> >      f = fopen(filename, "wb");
> 
> I can address my nitpicks in my tree, no respin necessary.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 

Sounds good to me, thank you for the reviews!

- Josh

