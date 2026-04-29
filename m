Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB1BFF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 08:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI0PY-0004Xa-UQ; Wed, 29 Apr 2026 04:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wI0PX-0004Up-GV
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 04:36:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wI0PW-000812-9R
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 04:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777451805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GF3KtEjFIHV9Et9qv2TvJTJxTHQrDlCdJuDOTgXHCcw=;
 b=UC4p6+Td3igzNW2q5IiMzGWHaqGz0AaCqayOvhkjN8ICo9weD2l7IoNCv8PfaAMcWzszsC
 1TlpOj6mwoOJ5/E4nZIULPev0I/M/nsWeJP3pwiJai+fa2OTbIq4KVn23ieMgaBLza/z+7
 05MyFAPgeip18rslIpSeM7EkG4o+o6M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-goHEn2M_NEiDGp40JwyLqg-1; Wed,
 29 Apr 2026 04:36:44 -0400
X-MC-Unique: goHEn2M_NEiDGp40JwyLqg-1
X-Mimecast-MFC-AGG-ID: goHEn2M_NEiDGp40JwyLqg_1777451803
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F4861956094; Wed, 29 Apr 2026 08:36:43 +0000 (UTC)
Received: from localhost (unknown [10.44.22.34])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 05CDB19560AB; Wed, 29 Apr 2026 08:36:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 6/6] target-info: replace target_info() in system-mode
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Anton Johansson <anjo@rev.ng>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20260428234519.1812371-7-pierrick.bouvier@oss.qualcomm.com>
References: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
 <20260428234519.1812371-7-pierrick.bouvier@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 12:36:03 +0400
Message-Id: <177745176387.2166241.12325520330683343446.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=327;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=V+fYQd3mR6xcFvGW0YZfCrDvQ0NQIjGPVrxxsKmI6RA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8cL3hmzX4XiBlT/tY8e595D24PQhW5qYV3BmS
 2BY+P5EsTGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafHC9wAKCRDa6OEJdZac
 5T8NEAC5q7z1l2P36iF7lhyHWKm1Tq7CAF4+0xofiE3oK9eEVFMgDmCdTQ2JXLfRy4lvj292RPA
 VmSLIfWJAR6X9aGLMgU1fkHvMBoKbgIdz1BhEY1rJO4FWn9m8Fyv7SXKd0i7TyJ4QdSaJFGLDtt
 qsuDM4Egedw5DkyPmDHJHO3JBV7Hs3JQSUbuWFm0sMjC8y/ohKHFAuo/HwCKSVPFDZHLfEGbm7O
 vh4P3KPZGYTs4fzJnokwIm7RyUe7rEaPm1UDwF7z1N/bcXoNEtajm72kvKqo/vc5gV5ovG1bEtH
 bPnZgaDTskWmjhvv4HFz3Y6jcVVPZ9dq7aF8EYioCsOX1pxjn9kTix5bednpfcyZ5UNB5GWkvTG
 wTv8I77Ibulaa75Q5rcSVeELbpx4oC+R+1tYGEI/bZ6XY+V6i/SRrK1LU/7714iNuvqaMxkcMjE
 ZzZxILCaNT9refLNzlHdobAwvqO4wI2CmvocaXpUPsqEDSuhLCo/b8u+kxDEGtNIoPcl4X/9Xfb
 rMyAk4Ws6RkluuCcPO9c7JrPR/tOpTrINuB0akchcSfF6CBR24U0SrPog8BW7iO0LdGKcH49dvz
 LbRO1+8EdZ+rrwB5HardXdMSiurkn7iZwwe+re5r/Shl9IfUPpfTD9Uz/YVdfog5f4peUTDawJt
 RdHujjVk5qS5Krg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Tue, 28 Apr 2026 16:45:19 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> We now can use TargetInfo information available from QOM, and remove
> duplicated target_info() symbol.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


