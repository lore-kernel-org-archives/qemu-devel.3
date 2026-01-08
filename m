Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D7CD148A3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 07:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdkfc-0001tr-2J; Thu, 08 Jan 2026 02:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdkfZ-0001kQ-8w
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:42:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdkfX-0005Db-Mi
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767858174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k3FzPRS+RgMd8UQLcnPbqoudPHP8jY+HPpfvQH1V/9E=;
 b=Eoqsk7scOJJBWZ86JrMKzmOyfICPfkRiK4Tp8/MscS5HfmBj7sXH+MAKYGSfxo4xBJ6WOH
 +KhHLvgEn89fwmQluhAup9jtoVjoa+oqrMoGkTAu2O9IGpiYhzQrit7Y/D1SRVC2baKe9v
 CKrZsFHJens6vUM2n4gYKNJebHZvBuo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-3WipRJTAPa2juzPfQXW3xA-1; Thu,
 08 Jan 2026 02:42:50 -0500
X-MC-Unique: 3WipRJTAPa2juzPfQXW3xA-1
X-Mimecast-MFC-AGG-ID: 3WipRJTAPa2juzPfQXW3xA_1767858168
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58352195608A; Thu,  8 Jan 2026 07:42:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E88A18004D8; Thu,  8 Jan 2026 07:42:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8B20D21E66CC; Thu, 08 Jan 2026 08:42:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Zhao Liu <zhao1.liu@intel.com>,  Marcelo Tosatti
 <mtosatti@redhat.com>,  Laurent Vivier <laurent@vivier.eu>,  Palmer
 Dabbelt <palmer@dabbelt.com>,  Alistair Francis
 <alistair.francis@wdc.com>,  Weiwei Li <liwei1518@gmail.com>,  Daniel
 Henrique Barboza <dbarboza@ventanamicro.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Yoshinori Sato
 <yoshinori.sato@nifty.com>,  Max Filippov <jcmvbkbc@gmail.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH 2/2] monitor/hmp: Reduce target-specific definitions
In-Reply-To: <20260107182019.51769-3-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 7 Jan 2026 19:20:19
 +0100")
References: <20260107182019.51769-1-philmd@linaro.org>
 <20260107182019.51769-3-philmd@linaro.org>
Date: Thu, 08 Jan 2026 08:42:43 +0100
Message-ID: <87jyxsczyk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> From "monitor/hmp-target.h", only the MonitorDef structure
> is target specific (by using the 'target_long' type). All
> the rest (even target_monitor_defs and target_get_monitor_def)
> can be exposed to target-agnostic units, allowing to build
> some of them in meson common source set.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

The only use of the ->get_value() callback I can see is in
get_monitor_def(), to implement HMP's $register feature.  I can't see
the callback being set.  Is it dead?


