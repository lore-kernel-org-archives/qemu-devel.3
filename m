Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15141C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 19:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk7YY-0001QK-6O; Tue, 12 Mar 2024 15:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1rk6S6-0002Q4-4E
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:02:18 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1rk6S2-0003G4-O7
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710266531; x=1741802531;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=cO3l58UBHZqKfGv89SnWy5HsTWKwX8kPCoof057qYGU=;
 b=lVKiYJHuTjVjarYy8TXXc+SsQV/XOcDMIoeQp7LCS+rbLgIZXYhyf7mo
 xYX+VGICfWkPvpPB5Mwx698FT8oQk2QkSmKMmA/EV6jR8PsddQqYl9sj5
 CNlMKqkyisgg8nVzX2VnktHaSsO7A8vzH1VIKSxGuUrIyjKDZfoVa8I73
 9MqroxVIFK3vYkUnhmMSJFtTmaofJq3DynV5rnOmugd901TaGFFGENlK8
 hLj4EzwYVLWrvlbD2Lw4OG2O98yyK/sWUSFSD9kOFH8ki9jZmEUGsKPZc
 yXJhQZrbHVrDFeprzz2qMHOCvQ3I/xJzKv2f57gOFMJcU1fHJV+lwKaVZ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="16394498"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="16394498"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 11:02:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="11521531"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 11:02:03 -0700
Date: Tue, 12 Mar 2024 11:02:01 -0700
From: Isaku Yamahata <isaku.yamahata@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, isaku.yamahata@intel.com,
 isaku.yamahata@linux.intel.com
Subject: Re: [PATCH v5 49/65] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
Message-ID: <20240312180201.GI935089@ls.amr.corp.intel.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-50-xiaoyao.li@intel.com>
 <Ze7Ojzty99AbShE3@redhat.com>
 <0f5e1559-bd65-4f3b-bd7a-b166f53dce38@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f5e1559-bd65-4f3b-bd7a-b166f53dce38@intel.com>
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=isaku.yamahata@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Mar 2024 15:12:55 -0400
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

On Tue, Mar 12, 2024 at 03:44:32PM +0800,
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> On 3/11/2024 5:27 PM, Daniel P. Berrangé wrote:
> > On Thu, Feb 29, 2024 at 01:37:10AM -0500, Xiaoyao Li wrote:
> > > From: Isaku Yamahata <isaku.yamahata@intel.com>
> > > 
> > > Add property "quote-generation-socket" to tdx-guest, which is a property
> > > of type SocketAddress to specify Quote Generation Service(QGS).
> > > 
> > > On request of GetQuote, it connects to the QGS socket, read request
> > > data from shared guest memory, send the request data to the QGS,
> > > and store the response into shared guest memory, at last notify
> > > TD guest by interrupt.
> > > 
> > > command line example:
> > >    qemu-system-x86_64 \
> > >      -object '{"qom-type":"tdx-guest","id":"tdx0","quote-generation-socket":{"type": "vsock", "cid":"1","port":"1234"}}' \
> > 
> > Can you illustrate this with 'unix' sockets, not 'vsock'.
> 
> Are you suggesting only updating the commit message to an example of unix
> socket? Or you want the code to test with some unix socket QGS?
> 
> (It seems the QGS I got for testing, only supports vsock socket. Because at
> the time when it got developed, it was supposed to communicate with drivers
> inside TD guest directly not via VMM (KVM+QEMU). Anyway, I will talk to
> internal folks to see if any plan to support unix socket.)

You can use small utility to proxy sockets for testing purpose. The famous one
is socat or nmap ncat. They support vsock. At least their latest version does.

QGS <-vsock-> socat <-unix domain-> qemu
-- 
Isaku Yamahata <isaku.yamahata@intel.com>

