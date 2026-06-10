Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04F4CD98C5
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQI1-0000kq-E7; Wed, 10 Jun 2026 17:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQHv-0000Yo-R5
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:16:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQHu-0007FN-D7
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xnA3veJdbm0ZMoe5CdAWd75WI/uqHc19rMhfFOVeoOo=;
 b=abUQxFmVioRBuXqLzIt+d9O4TG+tAoYlzTzfJ39JfQuiNKzTC77+yfUVmOethULc0uwtwI
 dugoqEPHRDyWLQ+ujc4qvi0nbwoWLHMClewbiaZSyYDlBrBfkvAWa4Lpj+1P4Slgz7ibTY
 g2D0cifeIGHGECF8eNPcvdS3NYxEGJY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-OMuLfB84MQa507YOEb3ilQ-1; Wed,
 10 Jun 2026 17:16:33 -0400
X-MC-Unique: OMuLfB84MQa507YOEb3ilQ-1
X-Mimecast-MFC-AGG-ID: OMuLfB84MQa507YOEb3ilQ_1781126192
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4168D18600E3; Wed, 10 Jun 2026 21:16:32 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C66AB1800347; Wed, 10 Jun 2026 21:16:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 30/35] tests/functional: add a stress test for
 monitor hot unplug
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260610123415.2883603-31-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-31-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600396.209622.4725663320926497079.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1405;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=J0KztrMyE/g2dB6yK6G74N8AQnMtijiW9UEHvm8J4QY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdOFG5fkfg0gbuqcZBDT5u7HCj90R0hnd5c3u
 Zi8+5FnbM2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainThQAKCRDa6OEJdZac
 5bm/EACTwlqDcUM0Yl6cU4NObxYXN/Im9EopIRoo8meeXnPA+LnLr8eC4H28/Xf0ftDH30w7MgF
 azE81JygU0pnUkLTbVOGOVB0yp0TTGs9bSsZEh9mgr8EgBQ0Qu+UtWRR8ztSw9UNGMCit/bMidY
 8n+/ncBeHjV1M4qnp3i1o1nnX5eX7QLukjywSsdXO9pOZ9O20ly/+yrQ0ndzfzkDUhti4Y1tZ7K
 0rok5kTJlD59WJGxXlTanfD1coEd4Fy6HKNFl8NK4/+pVpK8s9o+jKJ1nfxRk4m26LlDICVI3iZ
 hSfABEqfBMPpf6IFwcCH2rONuGky7ZRc8kq2NxQnVYEBeewWlzo5NXnofJw7bBYwjVOQr+2p6Cy
 HFAnvJnPlGVmFDrxw9qoMg4mmOiLjVcJ8dVcBUT+hbPOHldrR4eGZeINxpubNWzWk2MCeQ28MHo
 jLI0ncxO7pPapRJvPrvGp6vxJwWm+Cdg+IGeFcq3osx0itH6e+v6IY4WRyVDWLy8Yhs0hIe9RrK
 V25DEIPLQNmnduvPkXUSNVv3lxJBaoXQZZ1+BGgl22vfH/wfULrNTE573wyRGmkayK90Hcn/6ya
 oxDa6d3VQKBp5duL/vDKg/7HHN2KI4lO8726i4v8sEUKZ76BKi6MUsXoGe+grnnV2gXNPmt4wT4
 prYLN8M9pxw5Zcw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 10 Jun 2026 13:34:10 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> diff --git a/tests/functional/generic/test_monitor_hotplug.py b/tests/functional/generic/test_monitor_hotplug.py
> index 5d8a159eb00..03087faafc3 100755
> --- a/tests/functional/generic/test_monitor_hotplug.py
> +++ b/tests/functional/generic/test_monitor_hotplug.py
> @@ -163,6 +168,63 @@ def test_events_after_negotiation(self):
>          qmp.close()
>          self._remove_monitor()
>  
> +    def stress_mon(self, sock):
> +        async def main():
> +            qmp = QMPClient('testvm')
> +            await qmp.connect(sock)
> +            # Run query-version in a tight loop so that the
> +            # monitor thread/dispatcher is very busy at the
> +            # time we try to delete the monitor
> +            while True:
> +                try:
> +                    # A command which returns alot of data to make

"a lot"

> [ ... skip 38 lines ... ]
> +            sock = self._add_monitor()
> +            print ("# stress cycle %02d/%02d" % (i, repeat))
> +            stress = threading.Thread(target=self.stress_mon, args=[sock])
> +            stress.start()
> +            # Sleep upto 1/2 second to vary the races
> +            time.sleep(random.random() / 0.5)

* 0.5 or / 2  for the intended sleep

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


