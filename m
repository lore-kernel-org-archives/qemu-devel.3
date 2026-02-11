Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0B2EB5976
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 07:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq52D-0001uN-Ri; Wed, 11 Feb 2026 02:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vq52B-0001u9-JS
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 02:53:15 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vq528-00022u-UQ
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 02:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770796393; x=1802332393;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WQc749Zs2DK5CvC8/FvrLosFQo/2lLBuOiMbqzgQ6/g=;
 b=jvPSC8uT1ZZSwnl8FswEw8tCKO+UAjKZB+VffbgiUWKoGGUA5PAaxTOQ
 LVTE5aDFp0Klaz50BBJkLBtedtkxc/L1MxECCDM8nfmI8WWODdJDZtpR+
 eCqn/vSvRRJoIMZP4Hx1OfQBQn5mrcbW2eWmfj0e0Lffq/1kgZv5iSYZK
 HUZbI38hOnI+shr0CWbEtS5cEqbLofzPYqx0MoHNZaFZ7hEwPIwD1pfSq
 vStBoanhK510GtGCrtMr/m0X83rgZBi6VoDrDix9pdq7lITgq6d0KXDXw
 O7aRwsuERZkM0+bPph5SEjlxXb+Vv2tEt0e+/lSJFWXYCC2oN3L4D53Ns A==;
X-CSE-ConnectionGUID: Z8WFgQahTjyMs7dBq0fmlw==
X-CSE-MsgGUID: 1oLmtyEZQvSCmSrkZQdgzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="74537198"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="74537198"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 23:53:10 -0800
X-CSE-ConnectionGUID: X+Ab3BD6QtyLZKE54QsSRA==
X-CSE-MsgGUID: xaTm82lTTx6x4QnydyRXTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="249813093"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 10 Feb 2026 23:53:06 -0800
Date: Wed, 11 Feb 2026 16:19:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 07/21] qom/object: introduce user interaction flags
 for properties
Message-ID: <aYw7eDvGB14wdN4V@intel.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <20260210032348.987549-8-zhao1.liu@intel.com>
 <aYr_NE0c0LsVz8zx@redhat.com> <aYsBLtwVWgSVc_NF@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYsBLtwVWgSVc_NF@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> > > diff --git a/include/qom/object.h b/include/qom/object.h
> > > index 856b12e7289c..1b77429aa28b 100644
> > > --- a/include/qom/object.h
> > > +++ b/include/qom/object.h
> > > @@ -109,6 +109,30 @@ typedef enum {
> > >       * will automatically add a getter and a setter to this property.
> > >       */
> > >      OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
> > > +    /*
> > > +     * The property was explicitly set by an external user.
> > > +     *
> > > +     * This flag is set whenever the property is modified via external interfaces
> > > +     * (CLI, QMP, HMP). It allows internal code to distinguish whether the
> > > +     * property has been modified by the user.
> > > +     *
> > > +     * Once set, this flag persists even if the property value is subsequently
> > > +     * overwritten by internal logic. It is NOT automatically cleared and must
> > > +     * be explicitly cleared using object_property_clear_flags().
> > > +     */
> > > +    OBJ_PROP_FLAG_USER_SET = BIT(2),
> > > +    /*
> > > +     * The property is deprecated and will be removed in the future version.
> > > +     *
> > > +     * Any setting to this property by the user will raise a deprecation warning.
> > > +     */
> > > +    OBJ_PROP_FLAG_DEPRECATED = BIT(3),
> > > +    /*
> > > +     * The property is internal only and cannot be set by the user.
> > > +     *
> > > +     * Any setting to this property by the user will raise an error.
> > > +     */
> > > +    OBJ_PROP_FLAG_INTERNAL = BIT(4),
> > >  } ObjectPropertyFlags;
> > 
> > I don't think this single enum design is very desirable, as it is mixing up
> > pieces of information with three distinct lifetimes / scopes.

In general, I treat all these flags as access control.
* OBJ_PROP_FLAD_{READ,WRITE,READWRITE} control read/write access -
  though I haven't done anything else, and I don't recheck against these
  flags when executing set/get accessors.

* OBJ_PROP_FLAG_{DEPRECATED,INTERNAL} are access restrictions for
  external users, from warning to error.

The above flags are initialized at property initialization stage.

* OBJ_PROP_FLAG_USER_SET - is a dynamic flag, which is set only when
  external user sets the property. It is used to check against
  OBJ_PROP_FLAG_{DEPRECATED,INTERNAL}.

In previous RFC [*], I split OBJ_PROP_FLAD_{READ,WRITE,READWRITE} from
other flags. But I think since they're all property flags, splitting
them up would just make things more fragmented.

[*]: https://lore.kernel.org/qemu-devel/20251202170502.3228625-2-zhao1.liu@intel.com/

> > The OBJ_PROP_FLAD_{READ,WRITE,READWRITE} values are scoped to the execution
> > of the property adder methods.
> > 
> > The OBJ_PROP_FLAG_{DEPRECATED,INTERNAL} values are scoped to the lifetime
> > of the class.
> >
> > The OBJ_PROP_FLAG_USER_SET value is scoped to the lifetime of the instance.

Hmm, I'm not sure about class/instance lifetime. All these flags are
attached to property and don't distinguish object class or object
instance.

 * Both object_class_property_add_full() and object_property_add_full
   could set flags.
 * But there're only object_property_{get,check,set,clear}_flags, w/o
   object_class level variants, since object_property_find() could
   search property of both class & instance.

> In fact, with my comment on the later patch, OBJ_PROP_FLAG_DEPRECATED should
> not be modelled as a boolean flag at all.  We need to record a const char*
> deprecation_note internally, so that warn_report can provide useful info
> to the user. We can turn that into a "bool deprecated" flag in the QAPI
> command response for querying properties.

Yes, I think that's good. If we could reach agreement on USER_SET at
least, I'll explore whether hints can be converted into QAPI flags,
since all of this ultimately relies on detecting user input.

In another point, the USER_SET detecting mechanism could be extended to
support several internal/deprecated mechanisms or features, so I think
it's useful...

Thanks,
Zhao


