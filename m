Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D06C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 11:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjeIc-0001HN-3k; Mon, 11 Mar 2024 07:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rjeIb-0001HE-Gb
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:58:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rjeIZ-0003qJ-Ag
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710158309;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nluu8/6lBq6Fh/Vq9/l2CaasEkbrWaMBya0wa6GdKNk=;
 b=NRXcTUxXc/+CWxIqicVu9gAAfiF/7c8knTlf5hjus4KBRO5k8igfWVtSVAE3qqjcUKi+Bv
 OSuUx7Qwd0jINflRq5DqKELecqpswCyc02nO9riK54GZNb2SU0h3SfraUdRfVsHWiZaLlP
 l56TKEphQ0k/k25EP1nEKmFEnWD1ehc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-ZD14C03TO7a4mXjaK06FRQ-1; Mon,
 11 Mar 2024 07:58:26 -0400
X-MC-Unique: ZD14C03TO7a4mXjaK06FRQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9C6029ABA03;
 Mon, 11 Mar 2024 11:58:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C9C03C20;
 Mon, 11 Mar 2024 11:58:24 +0000 (UTC)
Date: Mon, 11 Mar 2024 11:58:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Tim Wiederhake <twiederh@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/5] Generate x86 cpu features
Message-ID: <Ze7x3tXu8-UtV58c@redhat.com>
References: <20240206134739.15345-1-twiederh@redhat.com>
 <ZecplxvAjp07vnQ_@redhat.com>
 <f34bb533082099120ea35315bd70552820db9c57.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f34bb533082099120ea35315bd70552820db9c57.camel@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 11, 2024 at 12:32:03PM +0100, Tim Wiederhake wrote:
> On Tue, 2024-03-05 at 14:17 +0000, Daniel P. Berrangé wrote:
> > > Looking at this fresh, I'm left wondering why I didn't suggested
> > > using 'QMP' to expose this information when reviewing the earlier
> > > versions. I see Igor did indeed suggest this:
> > > 
> > >   
> > > https://lists.nongnu.org/archive/html/qemu-devel/2023-09/msg03905.html
> > > 
> > > Your commentry that "qom-list-properties" doesn't distinguish
> > > between CPU features and other random QOM properties is bang
> > > on the money.
> > > 
> > > I think what this highlights, is that 'qom-list-properties'
> > > is a very poor design/fit for the problem that management apps
> > > need to solve in this regard.
> > > 
> > > Libvirt should not need to manually exclude non-feature properties
> > > like 'check' 'enforce' 'migratable' etc.
> > > 
> > > QEMU already has this knowledge, as IIUC, 'query-cpu-model-
> > > expansion'
> > > can distinguish this:
> > > 
> > > query-cpu-model-expansion type=static model={'name':'Nehalem'}
> > > {
> > >     "return": {
> > >         "model": {
> > >             "name": "base",
> > >             "props": {
> > >                 "3dnow": false,
> > >                 ...snip...
> > >                 "xtpr": false
> > >             }
> > >         }
> > >     }
> > > }
> > > 
> > > We still have the problem that we're not exposing the CPUID/MSR
> > > leafs/register bits. So query-cpu-model-expansion isn't a fit
> > > for the problem.
> > > 
> > > Rather than try to design something super general purpose, I'd
> > > suggest we take a short cut and design something entirley x86
> > > specific, and simply mark the QMP command as "unstable"
> > > eg a 'x-query-x86-cpu-model-features', and then basically
> > > report all the information libvirt needs there.
> > > 
> > > This is functionally equivalent to what you expose in the YAML
> > > file, while still using QEMU's formal 'QMP' API mechanism, so
> > > we avoid inventing a new API concept via YAML.
> > > 
> > > I think this would avoid need to have a code generator refactor
> > > the CPU definitions too. We just need to expose the values of
> > > the existing CPUID_xxx constants against each register.
>
> I do not see the patches and your proposed x-query-x86-cpu-model-
> features QMP command being mutually exclusive.
> 
> In fact, I'd advocate for merging this patches still, as they provide a
> solution (albeit not through QMP) already whereas the QMP command would
> still need to be written.

I would not class this as an advantage for QEMU in merging this
series. It is defining what amounts to a new externally consumable
interface for QEMU, which is intended to be used by libvirt. Even
if it not consumed at runtime, it is still implying API guarantees.
QEMU really does not want to be adding new interfaces, as there is
a strong desire to reduce all external interaction with QEMU to
exclusively be QMP based.

>                           Additionally, there are more benefits to the
> generate-code approach, as the code generator can be extended to also
> generate the feature bits "#define CPUID_* (1U << ...)" in cpu.h,
> removing one more source of errors. And with the generated
> `feature_word_info` structure being virtually identical to the current
> version, I see no downsides: If the generator does become obsolete in
> the future, simply remove the python script and the yaml file, and all
> that is left is the original feature_word_info code, but better
> formatted.

If we external usage, then we're left with a pretty weak justification
for introducing a new custom code generator here IMHO.

In terms of the CPUID_ constants, I think what would make more sense
from QEMU's POV is to define them all as a QAPI enum.

eg

  { 'enum': 'CPUID',
    'data': [
        'fpu', 'vme', 'de', 'pse', 'tsc',
	.....
    ] }

which will result in QAPI generating constants

    CPUID_VME
    CPUID_FPU
    CPUID_DE
    ...etc

along with a constant <-> string conversion table.

The feature words could use the constants directly instead of their
string form

FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
    [FEAT_1_EDX] = {
        .type = CPUID_FEATURE_WORD,
        .features = {
	    [0] = CPUID_FPU,
    	    [1] = CPUID_VME,
	    [2] = CPUID_DE,
            ...etc...
        },
        .cpuid = {.eax = 1, .reg = R_EDX, },
        .tcg_features = TCG_FEATURES,
        .no_autoenable_flags = CPUID_HT,
    },


which I think encodes the information just as effectively as the yaml
file does.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


