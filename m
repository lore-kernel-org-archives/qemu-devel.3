Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C2BC83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 04:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXYO0-0002Di-Lg; Fri, 04 Jul 2025 00:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uXYNs-0002DE-HM
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 00:50:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uXYNq-0005UU-AU
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 00:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751604645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NUMW4P3yORtZN8D5J+yiS5FM/C39Lbdc4FB5Dw59YdY=;
 b=fE9UmaYta240KnmfAcF9/5iQmmi56O4qQ04vLSsWoirk33AHfRQloF9AzIhkMs8YO46bPL
 qvHTEYK794STYHEdZROoIxkGG6AE1bbBIstCLuu/KlRzNpAgkgxG0dyrV2RDuNs3xBQzw5
 EXvPJ+N62HDrJpmEeR5GbmjWgEL8WU0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-imHhp12zMBuvaqOZpqx3_A-1; Fri,
 04 Jul 2025 00:50:41 -0400
X-MC-Unique: imHhp12zMBuvaqOZpqx3_A-1
X-Mimecast-MFC-AGG-ID: imHhp12zMBuvaqOZpqx3_A_1751604639
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4ED2219560A2; Fri,  4 Jul 2025 04:50:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8EFE180035C; Fri,  4 Jul 2025 04:50:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 48A4721E6A27; Fri, 04 Jul 2025 06:50:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Zhao Liu <zhao1.liu@intel.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?=
 <alex.bennee@linaro.org>,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eduardo Habkost <eduardo@habkost.net>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Yanan Wang <wangyanan55@huawei.com>,  Eric
 Blake <eblake@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Laurent
 Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v6 07/39] accel/tcg: Remove 'info opcount' and
 @x-query-opcount
In-Reply-To: <20250703173248.44995-8-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 3 Jul 2025 19:32:13
 +0200")
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-8-philmd@linaro.org>
Date: Fri, 04 Jul 2025 06:50:35 +0200
Message-ID: <874ivstv8k.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Since commit 1b65b4f54c7 ("accel/tcg: remove CONFIG_PROFILER",
> released with QEMU v8.1.0) we get pointless output:
>
>   (qemu) info opcount
>   [TCG profiler not compiled]
>
> Remove that unstable and unuseful command.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


