Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB50AE7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 15:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM7pY-0003C7-Vy; Fri, 13 Dec 2024 10:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tM7pV-0003BX-RR
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:43:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tM7pT-0002C0-52
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734104625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RYU/4FdKkB0xorZ2TsYbbW9T90/h6t9JRgfYUWysE+s=;
 b=MXOU7Sqg6FNxQB0PGSV+Jd/SIUVIqOkIk8sOm4//gpdwnBQGAyV3BO6D6I9qcAKTh3PPrM
 iRNFM99WyMPzyzijIU9/B5jQS4srpwf1yrIXI71V9gwBq9I3xXU4CuaiNA+oBKA6W2BveW
 2Au3CcN5oMxmKBCfetxYETWg+nDmI0w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-a3xUOItJNimu-9lRPDa6NA-1; Fri,
 13 Dec 2024 10:43:41 -0500
X-MC-Unique: a3xUOItJNimu-9lRPDa6NA-1
X-Mimecast-MFC-AGG-ID: a3xUOItJNimu-9lRPDa6NA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D4951955E9C; Fri, 13 Dec 2024 15:43:40 +0000 (UTC)
Received: from localhost (dhcp-192-244.str.redhat.com [10.33.192.244])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A04D9195605A; Fri, 13 Dec 2024 15:43:38 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev
Subject: Re: [PATCH RFCv2 01/20] kvm: kvm_get_writable_id_regs
In-Reply-To: <f06b5f10-6ff4-4851-96db-56d6596bd176@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20241206112213.88394-1-cohuck@redhat.com>
 <20241206112213.88394-2-cohuck@redhat.com>
 <a1ad71d4-4148-42ee-b77a-fc4df1f5c2c0@linaro.org>
 <f06b5f10-6ff4-4851-96db-56d6596bd176@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Fri, 13 Dec 2024 16:43:35 +0100
Message-ID: <875xnnd1w8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Dec 12 2024, Eric Auger <eric.auger@redhat.com> wrote:

> Hi Richard,
>
> On 12/12/24 14:59, Richard Henderson wrote:
>> On 12/6/24 05:21, Cornelia Huck wrote:
>>> +#define NR_ID_REGS (3 * 8 * 8)
>>> +
>>> +typedef struct IdRegMap {
>>> +=C2=A0=C2=A0=C2=A0 uint64_t regs[NR_ID_REGS];
>>> +} IdRegMap;
>>> +
>>
>> Where does the NR_ID_REGS come from?=C2=A0 In particular the * 3?
>> IIRC, all of the id registers are in op0=3D3, op1=3D0, crn=3D0, crm=3D{0=
-7},
>> op2=3D{0-7}.
>
> According to the KVM API and code,
>
> "The Feature ID space is defined as the AArch64 System register space
> with +op0=3D=3D3, op1=3D=3D{0, 1, 3}, CRn=3D=3D0, CRm=3D=3D{0-7}, op2=3D=
=3D{0-7}."
>
>
> hence that choice
>
> See:
> https://lore.kernel.org/all/20230919175017.538312-3-jingzhangos@google.co=
m/
>
> Definitively we can add a comment

I've added

/*
 * ID registers in op0=3D=3D3, op1=3D=3D{0,1,3}, crn=3D0, crm=3D=3D{0-7}, o=
p2=3D=3D{0-7},
 * as used by the KVM_ARM_GET_REG_WRITABLE_MASKS ioctl call.
 */


