Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E76CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcIE4-00010B-6s; Wed, 24 Jun 2026 03:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wcIDy-000100-17
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:40:42 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wcIDu-0000Xq-Mz
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:40:41 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65O7eFnj059059
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Jun 2026 16:40:15 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=8bYr3NG9GAhvjy3dy0wa6iSbBOYqXMMC6I/PfIXSepM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1782286815; v=1;
 b=Rbst9mDl/Rz86X+EJ044SjiiqncObcnQNy0ob/oUEorOdYnt3BG2SbN5wxNTBcbh
 B/Y/l+Gcb1LBwiDKItDCt5O62Pu23QH/TULONDAzHOwg3Xq/deCcWEdqqSSbZI2E
 9wQBzCqZb/4EbfHLPhJGTf55o7ja6y1rFPbrx+76vr/or87cLZYTSsrbCyq2+Z27
 AkDHj9NXRYC5mQfLFPp40V1i+OO7Vz6Qo3xrCQZEkdtWQko2PV/U1hGswIMqGQXE
 U0VEum0+5hlvTplVIXd6hSU95p0tanI/PBpMBSlcChzGRqiGpOZ8UmC9iJZcV0Xy
 8yKXB3WMrF85xzLVrhVdhg==
Message-ID: <3d30118b-fc35-4498-b792-2b696684f03d@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 24 Jun 2026 16:40:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/34] ui: better console hotplug support
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/06/23 16:44, Marc-André Lureau wrote:
> Hi,
> 
> This series improves handling of dynamic consoles in ui/ (commit
> 9588d67e72 "console: minimal hotplug suport" added basic unplug &
> replug).  It allows for better hotplug of vfio-pci display devices or
> bochs-display (the other device supporting hotplug today), with GTK and
> D-Bus backends.
> 
> As usual, the first patches are various preliminary cleanups and fixes I
> hit while developping the rest, they could be merged earlier. I improved
> the display cleanup to replace the scattered atexit() handler, making
> leaks more visible to sanitizers.
> 
> Then console ADDED/REMOVED notifications are added, so display backends
> can react to hotplug. The GTK code is rework a bit to allow easier
> hotplug events handling. Finally, D-Bus supports is implemented with a
> qtest to exercise it.

For the whole series:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

