Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FD9C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 14:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgmZX-00070C-2E; Wed, 21 Aug 2024 10:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sgmZM-0006hy-R0
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 10:44:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sgmZG-0006kG-Gs
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 10:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724251448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nQj26tl6Oa52nTmxzWh6r9HvfYlcn+Q9FtHoMPtdBsI=;
 b=HM5WkV5sfWKa6/gexRHuFEAqZ9JSwhuRrMraKY1meDHPDSpqRT0HmraS8Z13qIZytVkiw+
 lwxgU1GHSTsmUK1023K7dZDKzGHGxsjj/iXcNyX71FYxETWNKhXmeudX2bSGjH0jA731xC
 /duyhb+g3qeFy9JGSCMNI23bSM+5ceU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-r9N91aAdMsSzuzAFtEqS8g-1; Wed, 21 Aug 2024 10:44:06 -0400
X-MC-Unique: r9N91aAdMsSzuzAFtEqS8g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37189fa7ad6so4931903f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 07:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724251443; x=1724856243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQj26tl6Oa52nTmxzWh6r9HvfYlcn+Q9FtHoMPtdBsI=;
 b=s4aUyAAEP+EeNhooxm+k5bRqyPhJYwsM761Xx1GkPpK00leTlt0+gG/ITM1f2KmZjn
 TgLdf90gBhPl6cL5GsMudm2ThCZ3qDhRvxexLRA1SYywaBCf9QzLkAxK4zR1t94Q0P7L
 vDoAu/SbJ9GDKJnTsUPA9S64iYPuzUM7QLy6ouh+mB2D0u4dM9aV+ZSChvsIyB5DFpY0
 X7fe1ADQLLOyNPCYNw5e+hAVL2dwzcaPPaYO6NuMi3lxA2Tx/rEgXn2Ez/UxSuccjzrN
 7M/dCsZi9qS9gjBIO9cGzdAKznQP+JJeBGD/pEAurK9wtNYmHiVRSLaINkjukVxRXp8M
 cWoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQq5yp8TgeHGsKk0CN5yqCVSp2S/DvOU29HyQGJRQqwxJdql/kZqUYfv+Gbw9k6HvpThHnBH1RZ/P5@nongnu.org
X-Gm-Message-State: AOJu0Yx0hNCLbutq7ly4vCrexiaLzkbSkRCy6EluzHYt8Y96Qz2PHNTV
 kJAzh5FMYCa7C28sj3rWxRbKIXog/Kbo/hm7YBhOQ54ciXl/QLyl3viSh2SgWsP//+uRpmqNh8t
 9iuAYzL+Qi3bhxVoEsdk5hrJuBzu4YF0Rxh2KawcdIugpA/kvfB5Z
X-Received: by 2002:a5d:49ce:0:b0:371:8c0b:4818 with SMTP id
 ffacd0b85a97d-372fd82ebbbmr1852527f8f.63.1724251443057; 
 Wed, 21 Aug 2024 07:44:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoEnUod26HxvMMly1bQ5eCRxvPL4qx1Z36ldwJZTUow+jRE+tnNQJzs8eUYGvj2ngcI6ZSWQ==
X-Received: by 2002:a5d:49ce:0:b0:371:8c0b:4818 with SMTP id
 ffacd0b85a97d-372fd82ebbbmr1852513f8f.63.1724251442406; 
 Wed, 21 Aug 2024 07:44:02 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898ac074sm15796207f8f.106.2024.08.21.07.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 07:44:01 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:44:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 righi.andrea@gmail.com
Subject: Re: [PATCH v5 3/3] tests/acpi: pc: update golden masters for DSDT
Message-ID: <20240821164400.1520b53c@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240814115736.1580337-4-ribalda@chromium.org>
References: <20240814115736.1580337-1-ribalda@chromium.org>
 <20240814115736.1580337-4-ribalda@chromium.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 14 Aug 2024 11:56:11 +0000
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Acked-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/data/acpi/x86/pc/DSDT                 | Bin 6830 -> 8527 bytes
>  tests/data/acpi/x86/pc/DSDT.acpierst        | Bin 6741 -> 8438 bytes
>  tests/data/acpi/x86/pc/DSDT.acpihmat        | Bin 8155 -> 9852 bytes
>  tests/data/acpi/x86/pc/DSDT.bridge          | Bin 13701 -> 15398 bytes
>  tests/data/acpi/x86/pc/DSDT.cphp            | Bin 7294 -> 8991 bytes
>  tests/data/acpi/x86/pc/DSDT.dimmpxm         | Bin 8484 -> 10181 bytes
>  tests/data/acpi/x86/pc/DSDT.hpbridge        | Bin 6781 -> 8478 bytes
>  tests/data/acpi/x86/pc/DSDT.hpbrroot        | Bin 3337 -> 5034 bytes
>  tests/data/acpi/x86/pc/DSDT.ipmikcs         | Bin 6902 -> 8599 bytes
>  tests/data/acpi/x86/pc/DSDT.memhp           | Bin 8189 -> 9886 bytes
>  tests/data/acpi/x86/pc/DSDT.nohpet          | Bin 6688 -> 8385 bytes
>  tests/data/acpi/x86/pc/DSDT.numamem         | Bin 6836 -> 8533 bytes
>  tests/data/acpi/x86/pc/DSDT.roothp          | Bin 10623 -> 12320 bytes
>  tests/data/acpi/x86/q35/DSDT.cxl            | Bin 9714 -> 13148 bytes
>  tests/data/acpi/x86/q35/DSDT.viot           | Bin 9464 -> 14615 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |  15 ---------------
>  16 files changed, 15 deletions(-)
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT b/tests/data/acpi/x86/pc/DSDT
> index c93ad6b7f83a168a1833d7dba1112dd2ab8a431f..92225236e717b2e522a2ee00492fb0ded418dc7b 100644
> GIT binary patch
> delta 1914
> zcmY+_OK#gR6a`RPmVc7`lmCBo0R=kA0^&G>phg?inPg;S4auBYNk<(QD7uD@yN<4c  
> zy?hjfcW1ixyAY2k+COjp9<$Ts^z`+EF^%V6*~i2_e7|0f*U|ay@$TW%^#1Mo`0dI3
> zn4Dj;_cBj&=gj%b=aUK74P4)vvhbg03BoakCc>R5`)T1^!}!jnPQHb~LHJI37!A>y  
> z%vW&(sU}jzaFu*D&L&2x7?mobZ(=zz+mvQpLeuzW9BqasMx}}9n{pS6^`=sdOGu>}  
> zXVXxP%SY7GmNerMTGEW8t<a3CN7T@E1+`)IZK=lDHcJt;v_sMkNjoe>tfhc<3EK5d
> z>mQ&zl`cyWwX{dl9!YyFMby%)k_Ko-(9Brc(~PA#Npq6sEJf7Pf~18sBec*^>m0I{  
> z_DR|&X`iKtS~?)<fTV-ajBg~OZ{C_}|A!<Ul61&YL@gbWbVSmTmO6*1p<~~a{g(qY
> zCh3@^h+0~bv?OWCQp6w)`#&M*#8`b!CoDzO(kV%&B%QJpQA=mijK_4Qq1Me<im0V?
> zlFmswXDOnVE=anNX59Wo4YhLikhOG4(j`fkEJf7P6-ifG>Q)RzMAOzky=#)LNxEh!
> zqLyw*x*_SNmI@S6L$}6Oe=qV1Zb`ajDWaC{NV+5Gj-`mc8GqpS8v5e)B;B(VQA-ab
> RJ&^RkQp6zr{V(~m_z%ZI%zOX<
> 
> delta 204
> zcmX@_w9b^vCD<ioofHEDBlkuwU8Z^ullWk#cmZ#&0B27F5f`rbfS?eD0wJb`gaU@d
> zMNXVk6S*1+suH=F7?KLAixQI<xR@D|7YIyF1}frYVPNp_^LAlKS)ejGnQ?*O<U}qO
> zxNtB-%0gZ^&k?9daB?yi6I{dzBw`E{VulMjGo%#MRwi)?FmV6>&(M*=z)(<~2(+*x
> Wg^{5kr6VDcp)_$x!saf{qv8OZMKp8(
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.acpierst b/tests/data/acpi/x86/pc/DSDT.acpierst
> index f643fa2d034053fa07f74f095565b64f021d4290..25b39955059409b177870800949eaf937cd39005 100644
> GIT binary patch
> delta 1914
> zcmY+_OK#gR6a`RPmVc7`lmGv2pg;%NfD>mB)F^^Db0hQ4nmMzQ42o``=vumnZXi?k
> z@=+Ato$1=|LOh~q|GoJ*W~a;P`Qwu@ji0}>&xw6_zg}*yqx0+I-NTpZ{p<Dd>Dm06  
> zoPT6*WuE5Fne(@=Cljt4xIUV)@SkT1!fgyqggaCA)55ui@tsSZd<%nv@SXH98lp9s
> zui^$$O{9w9D*0-hO^j4ADpf?^#ByY|Db2Wqrt!@<+6+yMN)ypH<t`TMO{E%_kV-Yq
> zrlA^_kEo?BX~reAq!~wBp&3_?sG;o&YQyT=QjN21mLh6thol{nc36s7O9AZ?wCkJJ
> zKR|gZU6vwhX^*5mlJ;1NsHIsY4bY6BnX$B|8B24L<|NHoim0UpNegL4XrZCjIb<#E
> zleACLK1&g`bU@MpNe7`B-$+E?Jeq3%ha?@6bjVUfEgg|`MADI#I)|vCW8akhmjg5=
> z>6oR6T3V8{Bx%V~#2^j(KOyMESba_>EJf7PDM_a!ow5{BOJ~xI$8@Hl*3DRosHJm~  
> z&Ph6FDWaAxNV<?_-2O!kwQ}~5wRB0+B}tboMby$2Nmp9xRt!Z%)7C$|Ym%->x@IY&
> zmTpM8A?c=;3KUU8x5id~FY*d*NxEezqL%JRx+Ce1rHH;6f8h5T`r`H^-Ln)?OAjPH
> Qko3S(#323iFZsUs5AYbxUH||9
> 
> delta 204
> zcmez7c-4f<CD<h-REmLtF?b`FE>pdSNqn$Vynr`XfU~E8hznPIKu`!nfe=$eLIFeK
> zA}7wNiChf@Rf$|o3`qsmMTtoaT+9r~3j`)70~K+yFfjP|dAl&AEKr%8%(y^sav~QC
> zTsW8^Wg#z|=Ll3JI60Y%2`=IU5-|n}F~fzN8Bz*rE0eec7`XrcXXr>_U?`|g1X|dU
> W!pKmN(vgtJP@1?TVRIK}jyM3xel%79
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.acpihmat b/tests/data/acpi/x86/pc/DSDT.acpihmat
> index 9d3695ff289036856886a093733926667a32a058..73a9ce59e9426b180fea0ec5820c4841ebdb6700 100644
> GIT binary patch
> delta 1914
> zcmY+_OODe(6a~<V<NV6b&-wpn%#hdt>h3UT5uq08dBhs%AyTmtMr;7F99F=TaZAOm
> zS1#+_nQ!v0T*u`~{=9#^*z@)L{Oye~t>rKKHgk_ZZrA(U<nr?L@c3^2;pO)9`PuxO  
> zUB24yRgo9oo6Dz<XA`emxV|%089uie!hH&Dga=a%^V0j437u<`LJNbV_?`4H8ly8d
> zRB;2TW>Up)okBIuW=5(Ql`3LrVmUI~mS$Q)+k|EsZO0}?rHL4tau<j7=2A^d$fcTQ  
> z^H@#GN7T}eG}96~(oCbB*i5TO)X;7Xb#e7wsixU3OA)oSN75cidn`q4q=5Db+7C?^
> z9-usxK1&g`bU@MpNe3)N)KXhZBh(Vq8b^C-Sz3^^AZfu;L@g~zT1qoPOAU42BWvl9
> zq(hPpS&FEoBa)6tI*QHoMk0phovHVKOwut)$1FwE(g{f?B%Nrf_lO!g4Ncj9IY3jA
> zPFaemr4>mll2$B5jMBLOGlI^H)8}-?QbaAClXOnfIZF|>bRo@jOcxsJ{DP&3TDm0Z  
> zlB7$PB5LW1q$_Er?O!!eCua{?OV=b_lXT5eL@nKrbfcwy!%##tUGvksCFz!=Tb3ef
> z>5im3lI|L*KoK=`Z(RNNBCp_{q<fYkYUzQb2a+CGiWr*d2mYv`U;L4zN0uUL>4~H#  
> QlAc(K7^T1eX8-p80f2$c3jhEB
> 
> delta 204
> zcmez4bK9QFCD<k8wmbs^<B5%2x=i&RCh@^e@dDml0nVNVA}(C<0YM=Q1wu>>2?Y#^
> zi<~&8CUP|tR3&mTF(egK7bPY!a4|C^FA$iV3{=F)!oc9;=k3CfvOr~WGUEcl$%$Mn
> zaN%Hvl!d%-o+D6^;N)a3Cb)<bNW>T@#0(d5W=JWhtxVz)VBr4$pP?g#fuW!}5olpY
> W3L`^7N=HH>LuulYgw0)?pJV{0Fg61K  
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.bridge b/tests/data/acpi/x86/pc/DSDT.bridge
> index 840b45f354ac14c858d0af8fbd31e97949a65d4b..4cef454e379e1009141694e0f4036a2a701c80d7 100644
> GIT binary patch
> delta 1914
> zcmY+_J8#=C6a`>fmS2+mlHc#GTY#W*mn7~G)Cht&yV0pb#$@QmF8vopr=ok&U)5j1  
> z9$t#VJ)4ew55!Lt?e8zYzh=kt@%h~cV;W!nWLJs3|9LszUPh<4$GiLM>BqOr<I}VG
> zH95Uz-^x7AoinG0Pe&838@RqPW#K>15`^0rnh1BM?5Blu4dXlKI{6j`2jM&EVKhW*
> zGGE0Fq?$+-!&UOtIGY%$VpOV#zKP|?Y*U(X2~FdhakLql7?mcXZ^~UP)|*N-E+Lg_
> zoJ~VDE+0`#Thfe6Xh}1Uwn8(m9#KQv71V~+x1}0q+bl)Y(hf;GB<-*iv6cebC1}?-
> zt$%>>RJtrh)Y2YFdnE0#6j4jFN*bUUK{I1%PcxS0B+W^hvlLNF3z8PnjL<?ut#im)  
> z+9zqBq<xkmYUzNa1CkCxGrp0CzIkJ+{U4HaNYWuo5w&zg(h*5VTIw94hK_wx_FoRr
> zn51KtB5G+#(vqYlOA&)K?Ei$I6Jzx`ov;*9OQ$5Al61;aL@k|3Gal2KhFUjcDWaCn
> zNjfL#oTZ3bx*+L7nsNIVHPp)4L)OwINtYyDvJ_EES0r6&sar7=5lvhF^sY&|Ch3}`
> zh+4WK>4v16S}IUP4c!`B{k_O5xFzY9rHER(Bk7K$JC-8)X8eKQYv^aUC+VK0h+29e
> S>4BsNmLdk}-+#%E_x}Nim&}L&  
> 
> delta 204
> zcmZ2h(VETW66_MvYRbUCD7leKm#N;vBtF<FUcj3xz}eG4#Dyz9ASi^PK!~X!p@1QA
> zkrU_CM6QN{szfd(hNOb(qQoQyE@p=01p<?kfr>a;7#Mu~yj>Vl7N|^4W?UdRIgyJ6
> zE*#8|vXB?fa|9|9oSe+X1Q&4vi5LTgnBhXs3@HV*l}TIz4BY?!GjyadFcefL0xj%F
> WVPq&s=}1UqC{0|Fu(^wKju8N_-!y;#
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.cphp b/tests/data/acpi/x86/pc/DSDT.cphp
> index dbc0141b2bbc77a6d806ff046dc137992c59a899..1dc928333d7ae7e4df6bb51d850af5e1cb480158 100644
> GIT binary patch
> delta 1914
> zcmY+_yN=U97zN;o<J`v1&AHzTY9vb9-3>@9BD5mgM?3@D4=+Ir4KIMGc_3bb;mkiC
> z>pz`O@*jCVk0<%}_Q!jBzMh{?uZ(H^`DI^c?(zHWdViZ-UY;Hv-^|~=+@3x?o1e4G
> z7yGp;^1^#_`S{^%;&ltxccv=C=QcyQPoa(QV5(tWdfzgkb8S*+VQ>_`lO9H6bjF4%  
> zZXnf6su-?QsHWM>NEM?}MGQ?WM`qj7OiO5+&`hK4*u<zb5kph%;;`Oas%Z(iRMTu8
> zt7-X&TH29jT0%#fX|xlYY4wO2+O453uD&bPG}~n<qL%hZ+9PR?rHG9b&^|%?q3OZ{
> zl&8{XDWaARNID?tfTf69YHMkPT7p{RXiqIm3z8NjEm(@Er6oyAX(ni?q0W0`Egh0{
> zNYWuo5w&zg(h*5Vv6<dT#L&Dm_5P1ZIwt9urHEQOA?bvq6D{=~QA4MpDf=%6XiCy4
> zOA)oSB56g^ilvBA8ux!j(3x@ioX%K^sHJm~&Ph6FDWaAxq?wNCLPMQjuoO{Cmn2=1
> zbjeagEnSgxCC#+`s|M=i>>+FEnxt!zu33txr5loNwA61HiioCbetNeg-I8?6QbaA?  
> zk#tAWT_Y7JqK58`tN&i)72K0_&r(D!J&^Q3(gRBoLo@xrA2sx|Ka%vwQba91k@Q5;
> O6H5`J^!MNF+vY!d*vzW{
> 
> delta 204
> zcmX}lKMR6T9EIWIpT%DU8ZAL%YY^1Xno1N#NV@CQyLSm1N-9Tby*Ovl7l^)JWsBo^
> zc;VdUpDDS48=m`svVGA|y(}hCU`M7$zOx*4U5flo2+>jVSb#ljqhyqeBO?`w$aX9N  
> zX-F$mrgdcKz-sNe;MG8;N@Yn#dcy(uz1^%?9a%CZwGsO-<C?UF9B^?uBxIuX{i5K2
> V$XI<?a0P-FF~goc<M-7ldq3fNG@}3j
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.dimmpxm b/tests/data/acpi/x86/pc/DSDT.dimmpxm
> index 1294f655d418dbdccc095e0d47ab220869a61a07..9f71d2e58b1707e733584e38dab7f73f9bda5eb7 100644
> GIT binary patch
> delta 1914
> zcmY+_J8s)R6a~-`Mg2(XNB#e0ssQO-S(XbULTp&>g{&d&$E`P!${Pr>1}`S7nA~~8
> zA>QqHrFX$O9FFvH{Cvz#m($DV7h@Xlf3mNMefWL79IvDE>(kxCx9R=s_38P=d`!;2  
> zvbQo%bLY(Y$M=&7*9~0XnzHbpX9>bFh9<(DDf?;RT*LUzrB1$u!9n;=dKeASn#@;m  
> z1F0rb#c-8;HO?kRsu-0jqHkh3GTW49Ttd_MW*lvXCPt-+=$mpEi}j{bjY~+S8fVi`
> zjmt;W(v~#i5?a!Xqpi@4t4Gw(b_KOz^=+xf*)~fNwX{Rh4oN#KMXaTOb_v?`P3s?^
> zJe4j>5w)~O(jG~BEJf7Ptda(3M$pVy+S81sIZ1Pp<}5|j(t@OgG$XXoQ0pABmi9^7  
> zCuyIhh*~-z>42nz(2Q>+qHo@sYX65M9g=j&Qba8sk#t1Tk(N4#sG(!ul>L_jG$!eo
> zrHEQulC&gg$x_514f{VK=)_okPA4oy)Y2(QrzD-S6j4iO(u~J+rlHo&Sc<5nbCS+U
> zI%g@OmM%!TkY?QeMGdub_K>x7Nzx@rmn=op(iKTpTIyB|MMTrqKfP;`u1UIPDWaBc  
> zNV*~Erj`m6QA4-JR(~(@3T{cdWhtVT?nt^L>5ip{z8Qbu_Zs@s?Mb?4DWaAhNO~aY
> Ofu)E+`uAUQv;PnBGR&(0
> 
> delta 204
> zcmX@=zr=~lCD<iIMUjDl(P|@?E>pdSNqn$Vynr`XfU~E8hznPIKu`!nfe=$eLIFeK
> zA}7wNiChf@Rf$|o3`qsmMTtoaT+9r~3j`)70~K+yFfjP|dAl&AEKr%8%(y^sav~QC
> zTsW8^Wg#z|=Ll3JI60Y%2`=IU5-|n}F~fzN8Bz*rE0eec7`XrcXXr>_U?`|g1X|dU
> W!pKmN(vgtJP@1?TVRIL!wHyFm@-w3V
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.hpbridge b/tests/data/acpi/x86/pc/DSDT.hpbridge
> index 8012b5eb3155377dc7995b73059ecb267d19232c..db420593a3c51eced25cd57420353fbb9ccdf63c 100644
> GIT binary patch
> delta 1914
> zcmY+_OK#gR6a`RPmVc7`lmCBY0RcMb2I4q_AVv_xnHyb0GiNu@S;rZ514UQWMHI~C
> zqbR&P)3x7)ctp|u|MlaToi3-h{f#k=pMSF3#6EspFURZX{Qh$P_+|R=etmg;GruS2
> z@7a$sPjlzY`T6N&!gT}Jccv`-=UIYqjG>8eZ_0jJIM*<~bE%VWVQ>(>lO9Gxv?lXa
> z+(4>{R54s7UyZYgkt#-|is+kIj?6Zt8JEyBz8OcGp@~sxBKoG>#bUjwRO1p-sm9qf  
> zRO9jywX`M8xP+E8<7g{1<LVJLv|T}MSbbZnakkA;L@n)*v_sMkOA%`+pk0D?ebf2}
> zC{Lx!QbaB7k+etB9!n9mG^?Zmnh`WJmi9DbX-?9dq&Z6wwX`5<A<YOaG}JnWtfhUD
> z_DR}jDWaARNID?tAT;9}iRhbmrrQ4@NrxmIvJ_EEM<gAQbfl%uA!_K@H)a3j0F6mH
> zW+|eUmLx4nTCx-|NW=b52s$xVpVJ9T5w&zm(kV%&EJf7PnKa`uooT3bGnOK1>71l<
> zlFnI*sHF>%E~FW^e^EoNoIPYMU6OQ3(j`j~wRA<&m6o~{LlM!m^-u4bq-&C{S&FEo  
> z8<K8Fx~ZiCMbyx(vDM#;yn<VjZdr<`r8|=DNV;PwqHo3@_`QaHb9<8RS&FEo2a+C0
> PdSEGHkpBIb{91ehwR6mC
> 
> delta 204
> zcmX}lu?m7v7{&49)x|FYjUZ@l4T9VwbtsIGbl0o*0WLv9iR37))*2SQK=gcJwm6<2
> ze>ivhYmpncVLk?w#ha$=yt1Oejtq}{XFVIb6#2Ula=?mMf<JBj#;K4eP7I06_B;Wp
> zNNb}?+ep`d&DL`v>PeL<wOMh}Iu0Nn{cbJW$gEOgo!Ebwx1@IDK*;=<kbz#)pcH`2  
> Uczak11yYnT$AQ1%&qcqEezU1GV*mgE
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.hpbrroot b/tests/data/acpi/x86/pc/DSDT.hpbrroot
> index 4fa0c6fe720f7859f0541b82f828c0329a3c0548..31b6adb4eb941e5bf0c02ec8c3819c9213adf022 100644
> GIT binary patch
> delta 1913
> zcmY+_yKdVs7zJS3mT#1NlkfL2YhEFVI|Ma~pw4dO0Wvjf!LA*<7o9p~?F;oyn8Tl<
> z@Sjb`{twJg6y=|r_Zxe<oSxsO#x%bFvj5%VpX=rRIzGQWJv`pdKD}L^zCN43)AKj`
> zqs+71dvpHs`DEgC1J`$^EW+ouiEy7n3*o_(gRJnrVM6Cpr_jRSFn%XJjK=7U4ORSr
> zRGU)8aFs$e%{GlxF)CHW(8O|Nwk6H9gq8`-G}?+yj7k$RH04(u)|*K+Eg_R?n$2Q0
> zEgw-!+tN%+XiGDVwqrA`9#KO(71YJmcchwTJ1j-i(k@B6B<->kv6cebBWN!)UATdA
> zS9&Z()Y3jl`y}nN6j4iUC5=!^P-`6Rsby(S(ww9@OA)oSAZa1Z1T8ewd5^561CkC%
> zI$$ZHmJUfeB<V0V(-Vmpns=t!{}D+?BptC7QA@`p9g}pdrQRcI=p-~{|K$KpNIGFD
> zqL!8<ElFCk6fsKU{^Pv^cRHq1<McV5vJ_EEXC$4GbjDIdEuBj<9n-mnIzMMAqLwa5
> zx*+L-rHER(B<WI`Y5SKo)XCXH*3uP8S0r7r6j4jpBwcH%Uo#XDO;^8qHzeJVbi-0a
> zE!~oIOVVvE6)2*H?u@JcUgQznk#xsWL@nKubWhSfOA$jez2FZT`r;2HJ+Kr}OOGTy
> QlJv+@#3=puyYZTT0De=<OaK4?
> 
> delta 203
> zcmZ3b-YLc966_Mf$;-gNs5g=8LA{4be6UlzfHzlwv!{WG3s-zVPzXbT5K}`!0Yl;<
> zC(fyfTnz<PiCjz!Nd?tKiAfAx%nZp31STf~6>+jKF!=a+yD+3IP??;}xIl1nA{Pr>
> zIG7=2AupWg2vj6EIhl(IF5(0dF$M}T!-bp~QVMD-leh#Jxc~oW=tyB;D5y>ZTG)}o
> V$WV~dk&wtxnz$rkvn@w1HvlZSGeiIY
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.ipmikcs b/tests/data/acpi/x86/pc/DSDT.ipmikcs
> index 0a891baf458abee4a772ffba7a31914ec22418ec..c2a0330d97d495298889b9e28bde2f90235cea88 100644
> GIT binary patch
> delta 1914
> zcmY+_Np9OP7zJQjmM0A!<atI9P@tP0AhELuViZB0z0or?d-fLDb=3<LJxdSK3v|mo
> z{uG7(?ey&bLHtC~{{Q*yl%22Vm$whbwEq6iJ|_0@=k0ob8(&_ZPmiBw53jf9uP^4;
> z^zuFXQRQjwoVk2?I-79a!u6f03jcYQAl%2$MmU+OObh2)#&@nw@+}Mw!*|ldXo%Ki
> zzKR=2HIXWY>*T9(HZfAgs8kVs6U&j=wlw1s+Qv8IXgf49DosS+l)G50H<fB!LMqib  
> zn}%v!KBAU(q#2jck!Bq2gl1elqK0;Bs12*{N;S@QS&FEoJ(BiF+G8nVBL%ci(7tb4
> z{{ZEw^jV6ir2~=<NIGCCqLya0G(a<gX2#N<W-QG~nv*nVDWaAZBrT*Fp@oK8=a99u
> zBxy;~lBI}RIwa|kq{GmRZzQ5`-kEy;M<gAQbi`6bEgh3|OwzHII)|vC6W^5mmjg5*
> z>4c?-T3V5`B5B1^#2^j(KPBkYSba{XEJf7P8A)d(ov{>AOXt#z$8@ft*3DUpsHF>%  
> zE=amyDWaAxNxGC~-2P<)wQ}~5wRA<&6-ietMby$YN!MEH)(k~N(>6c78<K8Fx?w4z
> zmTpP9CF!=23KUU8cgEI#FY*fRNV;PwqL%JSx+m$LrHH;6f8Y-q`pq3kdSEG{mL5rZ
> QB<Yc*h(Y@2UsA5#0rkwxng9R*
> 
> delta 204
> zcmbR4{LPfhCD<k8n-l{BWBW!fU8Z^ullWk#cmZ#&0B27F5f`rbfS?eD0wJb`gaU@d
> zMNXVk6S*1+suH=F7?KLAixQI<xR@D|7YIyF1}frYVPNp_^LAlKS)ejGnQ?*O<U}qO
> zxNtB-%0gZ^&k?9daB?yi6I{dzBw`E{VulMjGo%#MRwi)?FmV6>&(M*=z)(<~2(+*x
> Wg^{5kr6VDcp)_$x!saecUI_p?z%-Ho
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.memhp b/tests/data/acpi/x86/pc/DSDT.memhp
> index 9b442a64cf711b33d80691fe84f1d3a6256f943b..c15a9fae947bb3929a30c60b7c0f2092705868f8 100644
> GIT binary patch
> delta 1914
> zcmY+_OK#gR6a`RPmVc7`ljZ+!)>(n>ph)5jf;dG`XKr*2&756{N8LctRdo>sbNMI=  
> z@6L4XcOf28wEus-y=14$>FxH(nAY>3>~mtDZr98Gb#i`xeR%p(J-%OGzrUH^v-8jF
> zSDB}|bLRZ*`DDU%3)gq1Ed1wLf^Z*08{xr}!?bX&Wqjw-B;Uf|D10Y9jD~1U=Bv1Y
> zR1>LUxK6$rXA>h;j7k;JH?bU<ZA&vQp>2FKj<!P+qtZn5O}UH3dQ+*!C8Sb~vuUWt  
> z<s)ioN1Aa79cjkVPH4u}BWh^3hT5?Du2kb}m!*hW+9PR?q&=1*Hc~+Q1nv8#^$$><
> zN}r{OS~?)<fTRPKB5G+?O9M0`Xl5+!X~xo=q&Z1*mLh6tLDE8+5n5=dbq-leha?@6
> zbjVUfEgg|`MAA`c#y1ktH}6cn|6`JlNjhdJqLxlbIw9#qOPxd1(5Y|A{>uTHl61;a
> zL@g~zT9UM6DPoX@{htwZW~@G^GnOK1X+_eCq!mjMwRA4ccueOSYTcZrh+4WJ>4KyS  
> zmLh8DlB7#%#_eA=P%CE-SxZ+WU6FLfQba9XlXR`6Zp~0cG;Q<KyCLa@q#KqZYU!4w
> zTas=YsX!4mbZ2b+_ad+0j-)%5B5LWLq<fO?S&HbJ@dy5(p+DS#qz9HFYUz=rN0J^{
> MiWsDS|0UJ_15D1$N&o-=
> 
> delta 204
> zcmX}lzY2m-9L4eDpT%DU8m`gO8U(dR>QGoA>8@Ar16+cJlE_h7FRfwG3q;Q+W{czb
> z@P+f()(i4NFRDj?Qh#WoURU!tbYjz|z+F#mkK$k-K@8L)5nwOJxHBrmnURWA<Oi05
> zG-Q=2vo<nxV6*c*@M<hGrLrU=z2gx4+3(h}jVzgw+KKa*SxZ_+F1WayQZmtN8k8Im
> VIcpC~u0ZfIVK}mP^1T`M@CUYNH9`OY
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.nohpet b/tests/data/acpi/x86/pc/DSDT.nohpet
> index 1754c6878839fc657230e1e714cd7c5142e0a77e..dd29f5cb620e5164601e303e37524530ddb12684 100644
> GIT binary patch
> delta 1914
> zcmY+_OK#gR6a`RPmVc7`lmGt!85igvK*mnoK~N(I;>?Y%p_#KQDLUu|imo8b=_=UE
> zM^Siprfa_o@ra`R>+a*2oi3-hj~inew|}xviGBKcy*yk;=l7S#r_a+b@7I^tH}iXP  
> z{+|6P^E7wPoS(m*Ot@~~`e@3+f1V`>4>2?m9!=R#3+EcfcP@4EEesCAchbXXh}LAj  
> ziW^8Zkt&9(<g0NuF;c~-R1tj>%aPfpG~*JQ#y8_=Gc++OO+??6yI8C@m1<l<D%Cif
> zhH6|sqL#L#8JEzKW*lvWW?Vg@hPErH4XbZUHO{tKim0U>l6FYiVJTuQ1++`hu5ViZ  
> z0OhH4S&FEoJ(BiF+G8oAmS&YSKr@17#?qc<EX_%plQd^3qLvmUEu<Ntg@#(^khQc=
> z(mqN1EJf7P0Z9iW9fW3lBN2V`XsZ1ml5|MYAxjapbVSk-Nk>}h9HNGfeN*;d4$zpS
> zW0oRnX-U$Oq$NucgEZ{_grE~+^*Noe6j4j3B%P9U%2Grvok=qu)0u`^H)AQHmd;5!
> zC+VD}h+4WJ=|Y-u`xiCT%GpEK(j`fkBwex;QA<}OU1_OXF%%I^TmST~NxCNKnx%+Z
> zx*_R?q?=kQP(%&g8e9Fn$Sb%d>6WF4TDl|Yj-)%5BKl_hf!}NBH@7G0o~4LddLZe6  
> Pqz9HF2I=2_$^GI#o+Hc)
> 
> delta 204
> zcmX@;xWI(VCD<iIL5hKa@ybRnU8Z^ullWk#cmZ#&0B27F5f`rbfS?eD0wJb`gaU@d
> zMNXVk6S*1+suH=F7?KLAixQI<xR@D|7YIyF1}frYVPNp_^LAlKS)ejGnQ?*O<U}qO
> zxNtB-%0gZ^&k?9daB?yi6I{dzBw`E{VulMjGo%#MRwi)?FmV6>&(M*=z)(<~2(+*x
> Wg^{5kr6VDcp)_$x!saecb8!HyWi$f-
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.numamem b/tests/data/acpi/x86/pc/DSDT.numamem
> index 9fc731d3d2bcde5e2612a8ccd81e12098134afe9..8a6b56fe7da18bf42c339d13b863aabf81780527 100644
> GIT binary patch
> delta 1914
> zcmY+_OK#gR6a`RPl7Eu?lmCBo0R=kA0^&G>phgkY>DcHRnmN0Yj=F)O-9^V;L{`CG  
> zK8nJ-GhO>#h({FdKX?C5`T2T&`SQ+~R{AS{pV+4#x9jOPzPvs^JbjowzTTccznGuX
> z%eVY{Rb+*8=JM&|*@WvBuJ27%`p@$O;S@uP@L;MzRyx-*zH@DoZ((p4zLOqCL$oIM
> zRop<TiBvIMCtr=TiIFNsrHbgASdPr5(u_+;jc>-$G&C_PO+??6yI8C@lWJT-Ce=8b
> zg=$<rqL#L$8JEzOW*lvYW?Vg@hIVSG4Xf`+HO_Weim0Vsl6FbjWhr7K1++)do^M+J
> z0OhIlSc<5neUkP`+Gi=EmgcoIKy!lT#?qeVEG<Y{khEYaqL!8<Eu|TurG{GPkhOF`
> z(g8^aEJf7PAxVcM9foFnBN2V`-qia)BI$^vBbFj+>6oNrl8&|1IYbSe_@?Z?9H0qF
> zCoDzO(u$-NNh_8j25H#;DM6>k>T^0}DWaCnNIE0wjHQTLI+tcVrgIIoZq8CfEnSdw
> zLDB_F5w&zl(xo)x_AeW#m9vMer7M!INV;MvqL!{ny4F&+W+)<>w)yGZkaR=R4NDQV
> zbW74LNw<wupoki}Gq(PFkymg>(j7|?wRBI?JxTX0MfA=11AoxaukJw714|LL^hnYp
> PNslZ=4AS3k$=~IF&pOOL
> 
> delta 204
> zcmccWw8fOmCD<ioixdL`<JOH_x=i&RCh@^e@dDml0nVNVA}(C<0YM=Q1wu>>2?Y#^
> zi<~&8CUP|tR3&mTF(egK7bPY!a4|C^FA$iV3{=F)!oc9;=k3CfvOr~WGUEcl$%$Mn
> zaN%Hvl!d%-o+D6^;N)a3Cb)<bNW>T@#0(d5W=JWhtxVz)VBr4$pP?g#fuW!}5olpY
> W3L`^7N=HH>LuulYgw0)?r^Nv%qBS-E  
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.roothp b/tests/data/acpi/x86/pc/DSDT.roothp
> index e654c83ebe40c413b204c711adcefe3f04655e8c..a16b0d9d4becec47fa3cf57ed0077ff6cff88908 100644
> GIT binary patch
> delta 1914
> zcmY+_OK#gR6a`RPmVc7`lmGvWIxCPZByk2oj3S6Lce{pW&a5KCqJwUr=$bmnDwxYh
> zQFwQzYrhNeh@$PDe}B)8=i|%OwK0wVf3vTNefV`b-(E(i*QdLO>*@XL<>~pw{F$77
> zW^ZMl=FXYZx5uLi*9~0Xn6mJnX9>b>3{8YPQ})xsxrXtbbDew(gM;v$^e`HtHJPvC  
> z22xF=is35xYMf1sR52=5MBl`6WVR{IxP+$h%{bZ&O^iwt(KqET7VAx=8kdktHO{7?
> z8kdi#r7da3CA6d&M_Zv8SC6Qn?Fwqc>f2I{vu&0lYH5e09g=ofidahl?Gm)>o7O)-  
> zc`99&B5G-mq&<@MSc<5nStSk7jG&pZw5J(MbCTvH%~^`5r3Fa~X+~(Fq1HKME$x%E
> zPtrb15w&zc(g8^ap&8#uMBltI)&37jIwa|krHEQOBI$^vBQ13fQA5YRDf=%6XiU;E
> zOA)oSBxy;~lBI}28uoue(2247oK9GZsHIbqPDwgtDWaCnq#2LtOhc`ku@q5D=Omqz
> zbk0&lEnSdwA<ek`iyCU>>>+FElB7$LE?J7Gr7M!IwA8H_iioDIe|py>U6XXpQbaA?
> zkaR=RO)V8DqK0mbt^Qu*72J|^%Th!w-H~)h(j7|?eKY>R?=|#?+mm$9Qba91kn}*(
> O14|Ku^xsGF{^b*&XU!!5
> 
> delta 204
> zcmX}lK?;IE7{&4D=*BMsjgAmOiy){Aq_ZfD5OuGkbATaeQ4+e8wo+{^x<GV5vyIF5
> z;}5S%+JJb-qhbbVj}OgRv025T6I&kn?shTe6#GF0HDYC=AYP7n6I80RAcj=s2a$qw
> zWQ|p4U1S=-Ztro(W>RNbW7mR=o<qpzuwUygvg?dkFV0_<9qB!}km_<u$-<y*QAt4M
> UqC2dl1|_RR;3(e7_iEm!KQx0i9RL6T
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.cxl b/tests/data/acpi/x86/q35/DSDT.cxl
> index afcdc0d0ba8e41bb70ac20a78dcc8562ca0cb74b..f561750cab8b061c123c041fe2209d74c7a740f1 100644
> GIT binary patch
> delta 3550
> zcmeI#&2G~`6b0aM;{4gppPfH7X(Cv$XVoQXpc1JNqTNv`J3wLy`$0SaEcy!UV1xPy
> zyaq1;FJR8x@uc@W0+M$*?VS34wLPQ!-T!`*?5=j#H;;{p_CJ&2G(G=%bGX_bUVnc6
> z<?hkxS!ADnJiL5$ZN3$kACgab8mDDxE??|-#($3R`H9Ih_w%HIunnP!aBlK`oRwu{
> zTnFo_<XTub@V}EDmWJq>`1`WfHl&Kh5*x-<!`g<CD%MIB(N)7`n$ip-G^H7qHhmLI
> zrHSa8;VQ8-Wdw`qW2uI<v9E^l5w)~M(v~#C(w1+A=@GTGP0)4)wSK@hOA)oSL(&dO
> zJ1j-i((b(!&@Mr{u4(UY6tb4~NZKQ5kEMuOnvgW9q#l|uG_fpANt%*0WhtVTW+cr>
> zn)zn9Pl!jTyZ?QX_DR}jDWaARNID?tfTf7886MtY1-1UUACh#)Qba8sk#t1T5laz|
> zQb5N99lNGIzNcfBB5G+)(ww9@OA)oSsH7fR5VSB>-th456)c^QbVAYzOA)nnO46w`
> z!|k7Hs4YumEuE2cM$#Ee5w&zq(m6@zz8Rp1uDLa5{@=17>4KySmLiJu_E-19!X*3V  
> z35|KeV<PG?mo(;*#$584h<;3el@(37GSNf-M9Ut#;xQ5ZnBRLB@4}dC8gtEKBI+?W
> zH0FlJ-0+x)e$3lH>-TiTz1`GDTz$kH_qh6qlii{|;$+9Fk2rZ6>LX5lHTWNnxY^ya
> H2S4I}`F&X$
> 
> delta 354
> zcmcbU_Q{*eCD<k8lPUuP<Nb|X!m`|c$}#c5PVv!AuF9J=WGxx%9XR6yf<hPygqRu<
> z3K$X>`LRz;<Z39WO5|c<NGhl<N=#zlVrEEQATT)@sECt=fx*Ym+l3(oB)|w4a0Chn
> zPEO`xf{QpoMVR3t&I~C9wUtR+0u0>$|1)%?FfbHUCkg@$??_=}C`jo@NMtBYT#_((  
> UnQAtQGiB5Uqcb<p(mTWg01Zc8kN^Mx
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.viot b/tests/data/acpi/x86/q35/DSDT.viot
> index 64e81f571120e3eb2b8c6c9545293a78c75b7bbd..8d98dd8845a60a08df5aff27097646bea4913b75 100644
> GIT binary patch
> literal 14615
> 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
> Xr;-K=W*~}zbc%dH{J}yAzsUO^S0<~(
> 
> delta 518
> zcmbPU^uv?OCD<k8hYAA&<CBeC!m`|6qA~HoPVv!Aj-rz_WS7)CaK;A&g)kHdF*PI<
> zFeEPWW1pJH)lg8C$i>8vR8U=%n8d)v%#gf5U~)205hn`+gO8uL3quM>fDta>2ow;U  
> zoXo`p7jc4$FvCTh8Bz*rE0eec7`XrcXXr>_U?`|g6a*UHk;2GOkkXNm$WWTNBw@0k  
> cstk%NEmQ}iD;0H7UFo4a2wl0^(DWHI0MXZo^8f$<
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index f81f4e2469..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,16 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/x86/pc/DSDT",
> -"tests/data/acpi/x86/pc/DSDT.acpierst",
> -"tests/data/acpi/x86/pc/DSDT.acpihmat",
> -"tests/data/acpi/x86/pc/DSDT.bridge",
> -"tests/data/acpi/x86/pc/DSDT.cphp",
> -"tests/data/acpi/x86/pc/DSDT.dimmpxm",
> -"tests/data/acpi/x86/pc/DSDT.hpbridge",
> -"tests/data/acpi/x86/pc/DSDT.hpbrroot",
> -"tests/data/acpi/x86/pc/DSDT.ipmikcs",
> -"tests/data/acpi/x86/pc/DSDT.memhp",
> -"tests/data/acpi/x86/pc/DSDT.nohpet",
> -"tests/data/acpi/x86/pc/DSDT.numamem",
> -"tests/data/acpi/x86/pc/DSDT.roothp",
> -"tests/data/acpi/x86/q35/DSDT.cxl",
> -"tests/data/acpi/x86/q35/DSDT.viot",


