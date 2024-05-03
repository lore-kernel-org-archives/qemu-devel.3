Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214BAC25B5C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2s8w-0007uB-QT; Fri, 03 May 2024 08:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2s8E-0007Fo-Bm
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:35:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2s8A-0002nZ-9T
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714739707;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pWj+HnS8N6/jcUpATLvn3zKB5cbBEMbtsZN5xw5kBws=;
 b=hCiTcJu9bROqKfo9Hb0IKv/4diCeHIYKDBnH4bJr6jii68a2hrNeb6iv7l1dklIIExFJDH
 NS1CLVzZ99qubgEYHdcc/QkFqojR0YT7SBX2Kb1mOvNKHqs7nadbgbELEYGuLFANaWEoj0
 brQDsqZHoBHODnrQg/74jeOM+aoCDps=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-n7i_lRwhMVOmwufLibs9aQ-1; Fri, 03 May 2024 08:35:04 -0400
X-MC-Unique: n7i_lRwhMVOmwufLibs9aQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72F5A886F07;
 Fri,  3 May 2024 12:35:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A93A40C6CC0;
 Fri,  3 May 2024 12:34:59 +0000 (UTC)
Date: Fri, 3 May 2024 13:34:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clegoate@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Subject: Re: [PATCH 00/14] hw: define and enforce a standard lifecycle for
 versioned machines
Message-ID: <ZjTZ8YrxElWp1A8x@redhat.com>
References: <20240501182759.2934195-1-berrange@redhat.com>
 <CAFEAcA9LTsdjHpip1F=BPhrRUbH++3eW4HjjH4Xn6yN18pHtjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9LTsdjHpip1F=BPhrRUbH++3eW4HjjH4Xn6yN18pHtjQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, May 03, 2024 at 01:14:27PM +0100, Peter Maydell wrote:
> On Wed, 1 May 2024 at 19:28, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > I wonder, however, whether we would benefit from changing how we
> > update the VERSION file.
> >
> > eg instead of re-using the micro digit to indicate a dev or rc
> > snapshot, represent those explicitly. eg "9.1.0-dev" and
> > "9.1.0-rc1", "9.1.0-rc2", etc in VERSION.
> >
> > We don't use the full QEMU_VERSION in the code in all that many
> > places. It appears in some help messages for command line tools,
> > and in QMP query-version response, and in a few other misc places.
> > At a glance it appears all of those places would easily handle a
> > tagged version.
> >
> > For release candidates in particular I think it would be saner
> > to show the user the actual version the release is about to become,
> > rather than the previous release's version. This would make the
> > reported version match the rc tarball naming too which would be
> > nice.
> 
> I think the theory behind the VERSION file is that we want
> to be able to express the version:
>  * purely numerically
>  * in a strictly ascending order
> 
> We expose the assumption of numeric versions in places like
> QMP's query-version command, which reports it as a set of ints.

Right, we have:

#     -> { "execute": "query-version" }
#     <- {
#           "return":{
#              "qemu":{
#                 "major":0,
#                 "minor":11,
#                 "micro":5
#              },
#              "package":""
#           }
#        }


We could add an extra field to it thus:


#     -> { "execute": "query-version" }
#     <- {
#           "return":{
#              "qemu":{
#                 "major":0,
#                 "minor":11,
#                 "micro":5,
#                 "tag": "rc2"
#              },
#              "package":""
#           }
#        }

arguably we are still in strictly ascending order for the
numeric part, we merely didn't bump the numeric part of
the value at rc releases.

> I think there's probably scope for making the "human friendly"
> version string be surfaced instead of the strictly-numeric
> one in more places, but I worry that breaking the "always
> numeric and ascending" rule might have subtle breakage for
> us or for downstream uses...

Downstream I see no issues. There are already many projects which
use a '-dev' or '-rcNN' suffix for tarballs of unreleased versions,
and distros have guidelines on how they deal with this.

In fact downstream already deals with it for QEMU, because they will
typically set packaging versioning based on the version as seen in
the tarball name, not the different version seen in the VERSION file
(and thus QMP).

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


