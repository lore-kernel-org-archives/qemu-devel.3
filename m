Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98AEC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 09:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1retZQ-00037f-7W; Tue, 27 Feb 2024 04:16:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1retZM-00035p-G3
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 04:16:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1retZE-00021e-C5
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 04:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709025363;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=v+RdFPWoEi4G0dpITK5HWGkYzQ6cUrxSrSkxlO/IF04=;
 b=Dn0AvxWhQMTdBYJeuyZkSfagRMl999WMln/d6SbNI/BRuFCXjjShmGcIjo24NEMmyEIQQs
 TcQjkVL2B9PPA/cgOdaQH84XJ43sUGEGWsF/DGM53OQvMpQpCN0R2jhlFXnF51LI5NVcFX
 HSdfl7jKHIZFDh92qXT8ASXqJkR5gRw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-TdEwwMHjOVWUMPyxAOmaHA-1; Tue, 27 Feb 2024 04:12:28 -0500
X-MC-Unique: TdEwwMHjOVWUMPyxAOmaHA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 567DA106D1AC;
 Tue, 27 Feb 2024 09:12:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0941BC185C0;
 Tue, 27 Feb 2024 09:12:22 +0000 (UTC)
Date: Tue, 27 Feb 2024 09:12:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC 4/8] hw/core: Add cache topology options in -smp
Message-ID: <Zd2ndJghXbmMHzBn@redhat.com>
References: <20240220092504.726064-1-zhao1.liu@linux.intel.com>
 <20240220092504.726064-5-zhao1.liu@linux.intel.com>
 <20240226153947.00006fd6@Huawei.com> <Zd2pWVH4/eo3HM8j@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zd2pWVH4/eo3HM8j@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 27, 2024 at 05:20:25PM +0800, Zhao Liu wrote:
> Hi Jonathan,
> 
> > Hi Zhao Liu
> > 
> > I like the scheme.  Strikes a good balance between complexity of description
> > and systems that actually exist. Sure there are systems with more cache
> > levels etc but they are rare and support can be easily added later
> > if people want to model them.
> 
> Thanks for your support!
> 
> [snip]
> 
> > > +static int smp_cache_string_to_topology(MachineState *ms,
> > 
> > Not a good name for a function that does rather more than that.
> 
> What about "smp_cache_get_valid_topology()"?
> 
> > 
> > > +                                        char *topo_str,
> > > +                                        CPUTopoLevel *topo,
> > > +                                        Error **errp)
> > > +{
> > > +    *topo = string_to_cpu_topo(topo_str);
> > > +
> > > +    if (*topo == CPU_TOPO_LEVEL_MAX || *topo == CPU_TOPO_LEVEL_INVALID) {
> > > +        error_setg(errp, "Invalid cache topology level: %s. The cache "
> > > +                   "topology should match the CPU topology level", topo_str);
> > > +        return -1;
> > > +    }
> > > +
> > > +    if (!machine_check_topo_support(ms, *topo)) {
> > > +        error_setg(errp, "Invalid cache topology level: %s. The topology "
> > > +                   "level is not supported by this machine", topo_str);
> > > +        return -1;
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +static void machine_parse_smp_cache_config(MachineState *ms,
> > > +                                           const SMPConfiguration *config,
> > > +                                           Error **errp)
> > > +{
> > > +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> > > +
> > > +    if (config->l1d_cache) {
> > > +        if (!mc->smp_props.l1_separated_cache_supported) {
> > > +            error_setg(errp, "L1 D-cache topology not "
> > > +                       "supported by this machine");
> > > +            return;
> > > +        }
> > > +
> > > +        if (smp_cache_string_to_topology(ms, config->l1d_cache,
> > > +            &ms->smp_cache.l1d, errp)) {
> > 
> > Indent is to wrong opening bracket.
> > Same for other cases.
> 
> Could you please educate me about the correct style here?
> I'm unsure if it should be indented by 4 spaces.

It needs to look like this:

        if (smp_cache_string_to_topology(ms, config->l1d_cache,
                                         &ms->smp_cache.l1d, errp)) {

so func parameters are aligned to the function calls' opening bracket,
not the 'if' statement's opening bracket.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


