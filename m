Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7CDCAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 09:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyS3v-0005vy-Or; Tue, 16 Sep 2025 05:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uyS3r-0005vl-JT
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 05:33:19 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uyS3l-00045d-AX
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 05:33:19 -0400
Received: from example.com (unknown [167.220.208.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 83BCD2015505;
 Tue, 16 Sep 2025 02:33:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 83BCD2015505
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1758015188;
 bh=Ni4zhHvUhyIBGzEHotqfaeOtkYpJCAQ8X3x85Wn3s/w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GE3AUdDO0FbPDIfL8+h+IiFg7O6J9StMcgAayOlKB4nI0hQRAbBMhsn9HqFBDqYjs
 YUqaf9TTNLz9usmGMYtLpt9sBcz7KLaCVrSmfOL0QT+fBbER5Xfk/9Hd6GuUoX2vgn
 tgxNvY2eTMhdfef3s6HLPMN+MMj8JfPrHe9fRohY=
Date: Tue, 16 Sep 2025 11:33:01 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
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
Message-ID: <aMkuzbCrzx0ftpGY@example.com>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
 <20250807143951.1154713-11-magnuskulke@linux.microsoft.com>
 <aK7q91-sjFp8nVIG@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aK7q91-sjFp8nVIG@redhat.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Daniel,

I am not aware of any such gotchas. The MSHV vCPU threads should
be regular threads that spend most of their time blocked in
ioctl(MSHV_RUN) calls, and as such they should be controllable by
the facilities you mentioned. I know that that folks who tested this
code have been using numactl for reliable performance assessments
without running into issues.

best,

magnus

