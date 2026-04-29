Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FDEFF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 08:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI0PQ-0004QE-JN; Wed, 29 Apr 2026 04:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wI0PI-0004PG-Iy
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 04:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wI0PH-0007yX-9u
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 04:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777451790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MFp7jzmv88vJ5NcRT5dloAB9vlIWlJbhgxOJhfQmhUE=;
 b=ddz4LqaKBkytzcT1v4U0vwUYnrwhFkEC1WSu1viNNrZndBSXTLxL97uDa1d7EwqAjnqamF
 cDn4oaTPseL4pfcVMlQmM0Zw/GkI59K+T8jnlM202/wcSIW7HNhe+KCfEnNTO7LUpiuS/u
 8p4yEBectfRZGdJ0LVzGlkZtOfM5hxY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-1ayG7UkiP8SnxHus4tV1Vw-1; Wed,
 29 Apr 2026 04:36:27 -0400
X-MC-Unique: 1ayG7UkiP8SnxHus4tV1Vw-1
X-Mimecast-MFC-AGG-ID: 1ayG7UkiP8SnxHus4tV1Vw_1777451786
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0ADE1956089; Wed, 29 Apr 2026 08:36:25 +0000 (UTC)
Received: from localhost (unknown [10.44.22.34])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 553AB1954199; Wed, 29 Apr 2026 08:36:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 3/6] system/vl: initialize QOM first
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Anton Johansson <anjo@rev.ng>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20260428234519.1812371-4-pierrick.bouvier@oss.qualcomm.com>
References: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
 <20260428234519.1812371-4-pierrick.bouvier@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 12:36:03 +0400
Message-Id: <177745176384.2166241.6921788598496135839.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=834;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=cPi2jWRM79AR65Rt+J7IdH1m64+OE2pG43tGRo7VKVU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8cL3Bgubct81/V0ln1Zr/K5DTvYJHk+vp8ueP
 uurEYcHN0OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafHC9wAKCRDa6OEJdZac
 5Z0wD/47jLVwhRInDRxNvfTFkzek4y+/WfMwxL6Qh8PP1rqq6y8uaom87pZ7Kq7osOy5HxI9oWj
 sBmvC4+7Uai/X9Id3Y9xFPApmq0tP43oSq4lfksFORpaCeLAXv3FD5R+DU4xtlXZfXeaWWnxuCT
 TLNr1B5YCOhElltX5bQd/yINSDG7XrYBDclrqZz/JBkF2IMJZCJ0UIn6KHypGiFlNYBs1HPDq2g
 o40hEAB9BM+wGRkdJajRRd0Xt9ihnPJ4l1Citpcz6rs3vpFzytn9J7e+0zF/nk8sSpRiIrtPtdZ
 BozlQ3SrnGQAkz/7Prfk4P6/s/FuVpvEBvzbj2zZcFfZSiA1TdzUo3w5Fc8w5Q0dtn+OFHDry5J
 H3jmdQLLIvuaaK8J0x1W7ekcSEeJgE7/1vb7Su1t+LkJkOsKSKKLVjzRc1Cx4hlZiipbkcl2gri
 pvYG+h40N1GOUnxnF4dysmnA8bygG+d+l71DIB5xwXbKpMEpgILrVgqe+dT2arVuAqTQq6J1iwr
 SjsU07s+hHSvACWk7vRtTkoJ+OK8N+fi7TAPkx50PnmI9beBfu66Kb++n6jX7HRl3tbpqSSbHJQ
 NFZxpys7ZhAViTnRwnGSldFP5oRCYCgwuZJp+uP1s6D7/8aBAt9JLY+absUemNbPN9CD/0N/TIt
 M7CMkcSUWRtnGcw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Tue, 28 Apr 2026 16:45:16 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> diff --git a/system/vl.c b/system/vl.c
> index 0e1fc217b4f..b4a5ea6f857 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2889,6 +2889,9 @@ void qemu_init(int argc, char **argv)
>      os_setup_limits();
>  
>      module_init_info(qemu_modinfo);
> +    /* We need to initialize QOM first to detect target */
> +    module_call_init(MODULE_INIT_QOM);
> +
>      module_allow_arch(target_name());

This change is not trivial. By moving the call here, we lose the
initializations from qemu_init_subsystems(). Verifying that all
type_init() code is safe to run without it is a tedious task. It might
be better to introduce a new MODULE_INIT_TARGET_INFO instead

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


