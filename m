Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9F5CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH4GD-0005T9-1P; Wed, 14 Oct 2026 15:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xH4GA-0005SX-NH
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:03:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xH4G8-0005hU-V7
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792004608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=26EhX6GK1ce8Kb2DnQ/rAf0kXovGnfJW54XyQkJ/odQ=;
 b=OYSFdk+VYqvSA69QaOtyHAz7SbCQFA0hvGYqfg3Fqa+F9E8WEE5lv1boH7c/qVa5Nd92j9
 sYkxfl9BbV6CYY9+f+dCtpXPcULls6KPCWHWdxFzp8rHvb+1XuIUCEWAd2BZ9uCDcVB+H8
 0FRmVg4qkhz8ySdsjaGhus7pj1jDT44=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513--8opzuQPMpe2MwG1_7bK_A-1; Wed,
 14 Oct 2026 19:03:24 +0000
X-MC-Unique: -8opzuQPMpe2MwG1_7bK_A-1
X-Mimecast-MFC-AGG-ID: -8opzuQPMpe2MwG1_7bK_A_1792004602
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 663461944ABF; Wed, 14 Oct 2026 19:02:57 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4FEB8195608E; Wed, 14 Oct 2026 19:02:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 5/8] hw/usb/redirect-server: Implement control transfers
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: marcandre.lureau@redhat.com, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261014075011.2708115-6-jamin_lin@aspeedtech.com>
References: <20261014075011.2708115-1-jamin_lin@aspeedtech.com>
 <20261014075011.2708115-6-jamin_lin@aspeedtech.com>
Date: Wed, 14 Oct 2026 23:02:50 +0400
Message-Id: <179200457098.338496.3819744892308921727.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=641;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=h+BPOlsZE8Tak27aE5pR90FHHAFI6j4EM4hdbO/HWu4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqz9Hc1k22aEc3kKR05Jnp6bgwAUDL26v5//Jhw
 pon4HnbnrmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas/R3AAKCRDa6OEJdZac
 5c+xD/4j9ExXio9dYtcvJdIOy2DFni0/aFRhqc2MCR5okspuDA0UoBStZmEUunhe1BGvkR6iyDO
 j6pnGfJO6ijebslo1a48mE7xwYy9hUlL88OLxCXrBuLvqi3z6UTQNzFZuMiouYAEOAJx2T0oKzT
 +k33861sBnGtT6juph+5uGjyc0VuOC6ATtFEVZZ7oJBGvnhexgzP6nfRhzwZ4BBYqi4jqPi8meQ
 L8Hm0mlBQHkuskD7PGIZlSosqxqnXjWSM/B2PQFk3FQsm9gvHNtTZ9eVS31coJbcP7Ls+Yoe1yS
 TRSweU8JRs9geO6RlsPiBb0syOZpIbXCor7zHn4xqjA/cDmAwmcM2OEbEfauZMX128+lTkRNMl0
 hq+LcSHHVGmKjMlUZjGYumwZproT6zA55eUs4PmaPl8mi6rOj9cw8/1W60m3QCNtxfzvbigL25W
 BGhhOA+U/TLPtqoyi9ITvbxEhoqxOfj/rHsUxWhsj4gZEILTFBLjKLN3GEVunEEgqwhCg6NTFtD
 9eSEp9aJIEvSQcTMCgsQsqmz3yYdmfLWCtQKx3On/gQH90u7juUAcY7/lSZSekg70LYYiV0jI1g
 7Ddlw4L3vtiisR6jqnHHtuWa1DzeSwJSi6ydailwtSjRr7jt2amT3/QdrG9og7qLL2ND7C6gNCQ
 syYiXYVA/Qzbr1A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Wed, 14 Oct 2026 07:50:18 +0000, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
> The host sends a control_packet. Turn it into the SETUP, DATA and
> STATUS tokens the QEMU USB core wants, run them on the device, and
> send the answer back.
> 
> The device may answer later, so we have to remember the packets we
> sent. Each one stays on a list until it comes back. We drop the whole
> list on a bus reset or a chardev close. When the host asks us to
> cancel a packet, we answer it and drop it.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


