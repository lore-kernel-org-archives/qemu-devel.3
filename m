Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E301DCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 17:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urK7L-0002Mx-1i; Wed, 27 Aug 2025 13:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1urK7H-0002Hd-8E
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 13:39:23 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1urK7D-0005h5-Q0
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 13:39:21 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 65AF7600AC;
 Wed, 27 Aug 2025 17:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1EFC4CEEB;
 Wed, 27 Aug 2025 17:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1756316355;
 bh=sIim0lpOhWT3vJ+aa8RUuqqStSCbim+1s3SKubhgeag=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J+93nleaK317G9QpNYWFPlqPl8coCy7/NpsYZT0EpKwoqUZD6n2xLEZwqOY1H+qzY
 wFcLIgr3p2SYLaClMcTTLBw/nan8+J3SGq3F4GeB6Eha5uetXRfNZ/TlYoqaWN7zZU
 6aRLhnWId4kpGo2GcoCX2wyYsJaOvCLY2PJOHPLMl/aHSlwzgor78YsfVcrhbraoPr
 +HRpKD1TYbcqQyLMDEEJqdKeTUR9mTTWHS+Dp5NqeMiTeB5QdMXZNA3mVkl8nU0nuz
 FNUrCRIq6JgRqSq4o957uyZ7zbw7pYp6LbsgDeUzoih4CAxTlqDKjtK3gOWuxqXO36
 x9HK6dxSC4/aw==
Date: Wed, 27 Aug 2025 17:39:13 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Magnus Kulke <magnus.kulke@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 10/26] accel/mshv: Add vCPU creation and execution loop
Message-ID: <aK9CwUoGGQzYuYx4@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
 <20250807143951.1154713-11-magnuskulke@linux.microsoft.com>
 <aK7q91-sjFp8nVIG@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aK7q91-sjFp8nVIG@redhat.com>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=wei.liu@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Aug 27, 2025 at 12:24:39PM +0100, Daniel P. Berrangé wrote:
[...]
> 
> > +static void *mshv_vcpu_thread(void *arg)
> > +{
> > +    CPUState *cpu = arg;
> > +    int ret;
> > +
> > +    rcu_register_thread();
> > +
> > +    bql_lock();
> > +    qemu_thread_get_self(cpu->thread);
> > +    cpu->thread_id = qemu_get_thread_id();
> 
> So every MSHV  vCPU has a corresponding Linux thread, similar
> to the model with KVM.  In libvirt we rely on the vCPU thread
> being controllable with all the normal Linux process related
> APIs. For example, setting thread CPU affinity, setting NUMA
> memory policy, setting scheduler priorities, putting threads
> into cgroups and applying a wide variety of cgroup controls.
> 
> Will there be any significant "gotchas" with the threads for
> MSHV vCPUs, that would mean the above libvirt controls would
> either raise errors, or silently not have any effect ?
> 

It depends on the scheduling model of the host.

MSHV supports two scheduling models: hypervisor-based and root
partition. Root partition is the term we use to describe the host VM --
think of it like the Dom0 VM in Xen.

In the hypervisor-based scheduling model, the VCPUs are scheduled by the
hypervisor. The root partition merely tells the hypervisor "this VCPU is
ready to run", and the hypervisor decides when and where to actually run
it. In this model, the VCPU threads, when scheduled, are shown as
blocked. Libvirt controls over the threads won't fail but have no
effect.

The root partition scheduling model is where the root (Linux) can decide
where and when to run the VCPUs.  Everything you mentioned should work
as expected.

For the upcoming project, we are going to use the root scheduling model.

Thanks,
Wei

P.S. In the hpyervsior-based scheduling mode, the hypervisor does allow
us to set CPU affinity for VCPUs or group them (similar to cgroup but
not the same) by making some hypercalls. We've been thinking about
mapping those into libvirt controls, but haven't made good progress on
that front. It deserves its own discussion.

