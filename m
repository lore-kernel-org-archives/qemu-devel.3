Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF157C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZG4e-0000Oz-Vo; Tue, 08 Jul 2025 17:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uZFEn-00078j-5F; Tue, 08 Jul 2025 16:48:26 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uZFEh-000318-Jj; Tue, 08 Jul 2025 16:48:23 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6097d144923so633358a12.1; 
 Tue, 08 Jul 2025 13:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752007697; x=1752612497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kkcX+QAvSJie8eQBvRFEjKJ+E/+cuGRopwk3TDiCqJM=;
 b=HlH28LE/ysY0jDy13Lu29LZEBiRoFxqpIs1tiXTBaw2ZFsJlfuF5Hzlh3lCcwHX5Fi
 bs7Bf2ahkGk37/oo1eD09mB7uK9OEdLiP929Xd+VvV/pIrkebsZ6B2Zef267CkWoP41j
 H1pJtaxEJ3TMxPWipd0EAAKwq/qtn+KS3JLJD/XNvUvmRkHt6IDC8oqUhgzVmM+du8EQ
 2+wjSJyb1+Nr9ukXnJdjJGaKz42YfReDEEKv89JIonmGtUuY5G6KRQ+Sjg7nM+61C+qX
 5gIIBqtXqioKDeumsxTcvVLgpI9jBFiu528CmO2uLc/bm1/xqs5CCXB0w2Q7Jug6VmQ2
 +moQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752007697; x=1752612497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kkcX+QAvSJie8eQBvRFEjKJ+E/+cuGRopwk3TDiCqJM=;
 b=hQEhwOCyGugDK/zdHGwpIC/ru/OlYQV2UkMSkGnGBc8JxTVJlM8otJjGKP9wzBHncs
 Vz1yRkgOPVoGBCkY0DctqREgcbRktwbdeWo5slGNO5LpQvWRD6yfp0FhbKdquHHEJ+11
 Z38HbSkfN/ifTfG3/IfmeUyhIHwoC/8aZD4q4wxNRLZdJDqi5u830UzUiiGjCNwN/qZE
 EFtfUvK8FBz9Jw1AkWYw3YHHT4cN+52ijhf3sHB3mF24qkwRAs6VkbuBebbS7/nYn31F
 p9nVTMc4bXpUKxE7zMgBF//9E/krVLwjBc70nKl+lHYGwlMSeQ8iUK2T422rY5AAZtQ7
 /F7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/Ks+Q7vtxX7ZsTaonq7Zxu5l9+QFwaMYWav8E7yILjbhRE5VXBQ/4Xr04ZpaBLeRREq2zm95qUQ==@nongnu.org,
 AJvYcCWWzDBK2zSKr3m1WGQxqFNMRPomUHksxA5LVk+A5V/OIiggzBOvnaWRO+mvGDFtCFNfq1sHpoCslbI=@nongnu.org
X-Gm-Message-State: AOJu0YxSqf4AXCSBweeZp60e08JPYo2vrBtv6z8ytqbWxrJ66nGIo4cS
 0O1RkX1oFHfhVyxMe83x+4O7AtZEBgJ2A8Ur2c8vndxQmINMePljwXAKe4Hv1A==
X-Gm-Gg: ASbGncuBrvK8MkFJFbnvQTTkMIA0m9Tk3m4qW+fTch7eKm1JpDnHKLwnbWUTkuSU+DX
 fk/T0CodAPCDm6kytblFNFerkrHvlPc7d3xQwyPniIoqWEQ5rB4jCzf5+Nn8Y9/OrXr0CP8a4Ei
 ew53CB4rKpbLep10S8KbdMOXG9J3mj4e0RV4mHYK6mWUgH2pvjfDwXAATcVrcsyi6ds7t61wLXd
 uHQ4Povr9/rDzQkA+LZlZt+5ChPwXBPj9EkkI6JGFARdTk9ymr67a9zUhkxIf0uti5JrVMnQf14
 i+0nHNBOemdOFDNNzIKgQdC9Mczul3EslxfVqjZ37jdk+lJWUxNnNzyEH2sEle7MDyODD6L+rfX
 YdxKsCFaIuUEb93Y8bqCmaPslb7p2TK2MQYmF+vbflOaJn2c6UK/ot7LhVFRx5LYmAt6XVTjFGl
 Ee67Ty764QPYpVmGK7
X-Google-Smtp-Source: AGHT+IHhZuchbRai8X58q0/b5ZMGqmivXJ7eUz8tIEPL40Y8ZqefJ97TU7zG27MMa0WZ2CM+R+MEng==
X-Received: by 2002:a05:6402:3716:b0:60f:d38f:f3c with SMTP id
 4fb4d7f45d1cf-6104bf20d1emr4521916a12.6.1752007696745; 
 Tue, 08 Jul 2025 13:48:16 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-18f0-be00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:18f0:be00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60fca66410bsm7647461a12.1.2025.07.08.13.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 13:48:16 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/3] pc-bios/dtb: Remove device tree blobs
Date: Tue,  8 Jul 2025 22:48:06 +0200
Message-ID: <20250708204806.1898-4-shentey@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708204806.1898-1-shentey@gmail.com>
References: <20250708204806.1898-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that the existance of a device tree compiler is enusred, it is possible to
always generate the DTBs from sources. This avoids checked in DTBs to become
inconsistent with their sources.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS                          |   2 +-
 pc-bios/dtb/bamboo.dtb               | Bin 3211 -> 0 bytes
 pc-bios/dtb/canyonlands.dtb          | Bin 9779 -> 0 bytes
 pc-bios/dtb/meson.build              |  16 +++++++---------
 pc-bios/dtb/petalogix-ml605.dtb      | Bin 9882 -> 0 bytes
 pc-bios/dtb/petalogix-s3adsp1800.dtb | Bin 8161 -> 0 bytes
 6 files changed, 8 insertions(+), 10 deletions(-)
 delete mode 100644 pc-bios/dtb/bamboo.dtb
 delete mode 100644 pc-bios/dtb/canyonlands.dtb
 delete mode 100644 pc-bios/dtb/petalogix-ml605.dtb
 delete mode 100644 pc-bios/dtb/petalogix-s3adsp1800.dtb

diff --git a/MAINTAINERS b/MAINTAINERS
index 1842c3dd83..36e5383a6f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1616,7 +1616,7 @@ F: hw/pci-host/ppc440_pcix.c
 F: hw/display/sm501*
 F: hw/ide/sii3112.c
 F: hw/rtc/m41t80.c
-F: pc-bios/dtb/canyonlands.dt[sb]
+F: pc-bios/dtb/canyonlands.dts
 F: pc-bios/u-boot-sam460ex-20100605.bin
 F: roms/u-boot-sam460ex
 F: docs/system/ppc/amigang.rst
diff --git a/pc-bios/dtb/bamboo.dtb b/pc-bios/dtb/bamboo.dtb
deleted file mode 100644
index d12e201aa0d855e5e2423b17976fb797177c00e5..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 3211
zcmcb>`|m9S15Y;t1A_$v1J?@%1_liV1_nU}1_l8JFkoEFz`(Tu%tR#^p<HGL1_l-=
zn~8ye0mkQNU|;~L0r7bl7#O4zbCZ*Gk`i;1^7BE;Vd9Ed#6jliK=m^w=42)orxwHX
zNHQ=mnClnhB<bfDB<UBY7G);pIHabT85kHF7=RQ(-2hT&k5!!sTph^0jL8M1V8fyM
zKz4(Sfw>*T2l)jomRwNk0JQ|<evq7dazQCb4#ejJ`7<EDJhdpmS;xf0z%>9Qg9wvg
z2p1kk;qs?gK}tY+L1v{h)>b$mxuc4Kfk6R@--E`V$H344G7_eLH4+~rz5}Y4oq>Vj
zcwS;jW?3po7;gVfXc)uv--q%+;R3>pxv9DNMU`+pAamT&#6WQi^A`grSSbToZ)RRe
zYEe;XL5Xg1eqKpYeojtm5mMNRF)%PFW+vt8lx8ODnwS`*7BE105Hmn-0<oS${QwG|
zKOg}ppM!yc5#*i&3=CjvLFz$jpi1C=gvA|Ho)N?cxev-`0EGcE9~1^4J_s`wrxbzA
z1E~eYE!e%qDMe8Cf~3Iqz}x~-1JVb=jL8L<dXo!q>IH=(NFN9@7UU#>3<ue(3Ja%#
zoFu5dpm2in(jlQ%kdtHr(f|z`SU7;p0+|8ggZvFk)1YWZPFLaVpBh6zg2gFCiMbGi
zK>9#xV17=_MY0{NPS?c1G`#?%8l)B$2B2~SWG@IarsO8V<Yi#~NXbn^G6~AVFbCvR
z26YAoNLtD-fQN?)%$)oJ<nVy<py7d}9^`kB8$bqv+zH|%hlK(I10%?vAT?kN%26N;
z;(%xnhK4K1k03XJ(jCYgn0evMKOI(q!Y?%`8Key)4tHm25_0;6@}TZSQV%j4WUdg@
z&mc2Ec7V(Sg(ZxS>~@em%x;i8$PAGCSV3-qn!|{thy<wx+2szA16ct}#|(;j#fE04
zrr?|kQpdr-z!3aC0mNhgu|W(L1_nkWs2G&b5YDgyloi3|faL8M7!QFAhRQSgK-~l4
z!`umy2l)ZyKNNRDi)fHq65R<h4&9w#F_2jx2Btefu7H=(SltOqJ0QJacV-$TL+TrI
zcs&9$+db0=GyXGC$~Pzv8vmJ@aP^?D4St^h@-Bl2G`)es5nH%{+=1yH3tG4b<SYhI
zxd!zk*6;y28t$Id+{9$vs@%*>NGPR1T?Nt)O1thLDP3^okd~N?sE<JD7F^bV<q;JE
zj0+7h5EmR_AoD<u3x1!#3lcyrKa(>ZQj-n903?YBPX_mb<V=tdNIxiiL2d%YFO<&!
z;)B8$#)qi|@nvCU52(BaRav?q!(hcRhz(K=NlTzC7z?!*l$pSF<U4Q{0jE!fcNf5l
zLE(nNeh+E^Fff2fkewEw@(JW1km>~>f`NenMuQ42kmI4kU<%ZT12Z5JATwkb7#LHX
zz=D_rQu!vpz`$6*!0-cI5y*@J1_s7v28h#<<v~sZmF*nxCL=-?Bqz-P)+B)tg|I+!
zQV=<iFCc<Y5+ny|zk%Wx#0Fu;<c$2{)I6{Xkb5K<7#JsFZQmi<fgpV#%&DB1l2Vjf
zT&$a%nv+w^pj@0;l?r9&=BK3QFeK;a79^HrCgr3uq$C&V79<v>=9Mr&ibn$|ZOD+4
zT9%od8edXbkjhY$n$D1%lb@Wen^u%sSelxbT**+9nVXuFSe%L^l&PDXn4FQSo0FNB
zstdA~Aq7JOrUpeC!bvVdYCVCSmYAFj@<?uKNk)DOLr!L1X@yQfMq*w{PAUU9SD`hz
z7(iau&CE+ltpMu>xmy`YAvi#a67$kiixK*Z8Okz?N=g%RbV16KON&6kp<7&#nwo-8
w1Pi5tqRiaHqDlr(RgP|uZf;_MZf;_6Hj=j7!~&?hi%U}SOG|VM5=$}|0Lt#hcK`qY

diff --git a/pc-bios/dtb/canyonlands.dtb b/pc-bios/dtb/canyonlands.dtb
deleted file mode 100644
index 9dce3443ad9578a8a4bb92ba6970cb2ae54d1ec3..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 9779
zcmcb>`|m9SgPJh|1A_$vgVGWP1_liV1_nU}1_l8JFktRyU{J~dGf@dfD3_Umfq@0e
zW@2Dqfbsbm7#KimKzxvS(uujr$vVl2d6oHjIf;2G#ZWykc||<(AoF#g<}oJbWF{7;
zg0+M6N;5DpnClnhB<bfDB<ZJ?WTY15rIt9PrkNQSq#782ZGowC#Gx(?Nu4AE1A{kQ
zU2$qrW?~M+G-IeLh#x`fg0ZSIfvW?B2V-(UDcG?{VFPj$ENno21BDe>EV-c60petM
zI7TNIl!D|ye&AzZV2}>TFHbEBaMm#~GjNRn$w1r#GAA9vh3m~m<5#2c`xqD)6p-At
z0FA$ifuRAU1!OnK{QXFLkoXy>UUmishTD0GC7ETZAYr)uZy6XEKw$vW{|_36ATbbT
z%uUVBFRFy=0htqxCdR|SzyR|XSRvF*#>~8u)S{x&f)d^2{JfH){G6QBBBZbrV_;xV
z%uLGFDa}mQH8C?ttzdxiAf|xa1ab}=)DJ8S42+<(1d;{GaWF72sxdGy9AIEz;6$ha
zNrN#+4Jb@taR=oy>OtKH<uic%3}S=*i_Oi3VB^4HMy{J-X$j`$3lz9nfPsP0o`Hcu
z4w|p!p)|-3pfK`+h6R)l_8%x5aQe@Pa{qzM2H6Mm-vcW6j|=KAZYT{hAD91Fp>c{e
z&4CI}Xqb>2e;~U-80NnZRPZ0D{07AfsO$yNAoFqg50vjfVa!;ZQUr=EkXle#1I|Ci
zDMiry1Cj!#Q<ytJYC!rxm@&BkQ*UwsPQ9Rf4blg~jL8MLAj3iSa=`K}k{HN+=;aI4
z4U7rUum|Y{`7at$?SS10;%9&?fT{uUi~jwul!e7-j!`nqUQjs*_HT}nZgOIBMk>_P
zph5#C1XByjBcQSYqzB|)P_YA|p>AN9fL4xff!2^vc}7qkg2f5QAE5jON{6s~43Yzt
z8z85HFk?YZ63lLKSojp=Bq2GmAScNLqy*+~FdL*7Y9|AzoPwDTD)*`oVZs2bCqVI^
z2#yIzodWV7I82IDiV|~?Y=iO*Ow$WM7J=*l`2!RtpmYba7lav;iz*9B@*NB<3=CkE
zB1kQ$jRC3e3ks6KWwS0sB?Gt-01~XIfC)j}2}&=ZdVqyNf`Ng70~ACszk<UPWG)DU
z+yM$tP#l94f!&c&UX+*aU}%VN23Rjh4VpWO^3oZg_Jf!p-$B9xVLvEGF)#$c(ok-4
zZX&dS1hOAghk(NjERGarU_PWU1gQhLQ;mUv5mdo~A{QhEN}r8Tb76c?9SsUoC?Db=
zXqbTf2Z~paAXFY47NGJ9#Mgk9<)Ataq!yHqKr~1WM8hyhJ%|kx2c<nw`3MfX)Qsdz
zhorQ$6a#p}2Bb~~mJUmclXO99pk9S>ak&ZPZ{+v^nFWebaNO?y3vvcH|FG=;%L2+r
zpaceXM`>{q#2N6U1dc;czEjN4NY2#F0XIHC=E37?|6h<Z7+_@tD11SA59D8vI+$Bv
zbsfx}{E~E#Rq#{`Qp*eSFF1Lolqc)vmw?<0G8`m_u<r*bYk`EpZiCqe3V)C~5FgY&
zfaOE5XTho=X$-_ij!zzF{DG8!^nlz4GRJ^{fpIoSkb!{#<QGs}fb@dYfM_XD4nays
zAoqd9L3%+nD1Je10-48{lA8$fY>I&eEQ^BOE)4Q-ab7{OPD*Z~ZgD|sVv(V-38<ul
zxD{k3C=6Kk{{=+>$XKvGkRL%|3`%Pt`(R-VawkX;NDQQAB{U5~`QUa0$RMzriW5s9
zjsoRah(|%{K=}ZYUqK3>2@Yxwl6yePKt|zp56D!QdqCy+7HF7(#6jT*qCs|YGB7ai
z1Y4Jqn+OtwhAU%!0Vvyo?SR+&`31;jGE@a5yg+t=w1dnBnG52B;u^*WxuI$UNCg7}
z3y204Fi^jN)WXZ?)FgPF1-Caf3Av36RROUV6#k%cSqSQGnB5?oKw%BzBfACJK9D@f
z3{aj0r5TVMNDLH*pm+xH8T0as;?r^xi!&SybRbCt94?@It(cgbqEl>SnVw^6Xq3m0
zoR+BzRtd5nX3k+Gx545OBoD1N!DfN%0g1uF3&e-HnXw?Ts3fx_Gd~Z~djgru&cMKU
zE*sPtgcQyoF;JoarCCVp7ScCC(rcKCRzHCJcrK*`9?uZ{pwa>qav1uJK-!_+2fG;*
zZs&>;b5k;l!O@3sg8~BsqXWo0;QkS^8_bXl0jXyL`6DYWtr${uz|3Vx2e*8%n~{iS
z1}n&n(&AKb0}Yy{z<yy|z`(#1hRq$up#C$gKmfS|92Tj0Wgx{MK3G5VH)!h_BP@*5
zz>WZ^hNMGqe3a@Y<>!}x1rcWaVqjnZr7VaUppa!uF33r7FoGo|u%E%@5xD#XRnMUQ
zoNiKbF~mn8vta24q#tAfsLuvsGv=kFB|8|Sm<5sp*U=z3kYZ?<z{~)d2W`TE?FRY%
z3Uo*WBnRT(XkbuMg6adMMUXLA(`H^`UJ6K(7`3?4F}836n+YoFAmN6bhLEBk?0%f_
z4>E%p)Z2iV0SYe|X2de|0rESjT#tsxfpmk-2c-qYykbK$Q&VvA2dM*zrN2)AF&RK?
z5Car$&!A#ZKD_M-<uiT)n+i!YAoZ{^1|$#4PoQ!L6waV92e}o+ozNBvNG*x(1R00!
zPOuorED!^nfe~?t)tw-<AdJ<WnMTQwaU^qCwgQJ8ybRAo8K=n11efxVZ~%p0`uhZs
zml#Bl+yDw2kbNKwvlA31AoqgAKr|>gLE#1CgUU>>SW!u`gP8@033dmly{A}QqLXW4
zSYiQ=MTp%XGeBi#2AaK~`W$2?%wEuV7|5L<`x%Q%N^%`cz=ng=fXz-!(Me1(H!*~C
zQ^0n@%=SPt8zc_W2QwSwXPDVw^WkBM+GZgkEJ4N*3`>w3KyCrsnO=~Y4~f7eSOkLP
zK{*gymVk<-iV9tjGEks`<Up3BzfS;l?HFKwgjRKsaz8aUF<G}NH!~Ara0=95kX~@z
z3F>@;q@hh67#GcaP}7tFRCa;g2{yAR9cHMZDa25anV@zd*sWk`BtyY`kg1S3hq_x7
zBm!cC^n%<C@+*i93KLKp667(2oh6AGU~d>2LrMXNS@1Y1Nz6d9u_O_cprG*%vLpR{
zf-tDb14??xcA)wTZifk(c8FlJ12&Gqh<*4NoK`_@jLu6fDbFtg7X=_Ug8Pr4NCAgA
zxFZW5WCU?diYxP=Ss1JzR+fS49*|yG+6IL&QvL*wA0qKV(qIhI0}6Lo{sr+ttqA0P
z04RPyYC!ry`4g0HKzxu|ko(i$CxE=la0D9eYzz!cpnMCq04m19z`&%<z`y{?vmkvS
zz8O>jjPHudM;SK-sSjabPzLq!Vd|4n>rSQu25?ae3m2wZ1_p3L2BaS3rhc^a2r_d9
zs+~-rv1(BI1L*<DuSJvJ&A<T86EOK>Nb;bxd<p7b5c>s`4GJqzx(3A&BweFSC%~o&
z!0rZxCpFRoDD#5cNQ?9U8mR#J36>r}85+cg+Q*RoJ^`GZ$Vm?%GePEn!XA_!K;Z%9
zgVO`D{6M7#WH*4)11RxB-N*z=4={O98o-erm_Q>4p!5LM2kxhW;tZ5NK$x*0InyE8
zAT=4O(FIc*U67m!N_J2_M&1SmKFAEHJV+@xZGrgku{Y2-UqNza1ybP&69Q=fsRbop
zm>WTCP`ty$)j<Lb3=B5Vc@!Q#(2NE&1A+{IVje!wtN~;$kB9FBNE8%23_N@%!1N!e
zIUx)Tj8z~<gH(V9uNW8@c%d|Swg@H%k_Y8MKG0}Ahy&{3f@lQh0VNtR7i<OC?=lPw
z%;rvDK}-T_56EvE3=GULWuP`8NKAl%f!POB7tCDvm<h5HP<{aMK~4cV9TcCb6%Hxj
z=!6b6fy@S}qa;2-eFbpc3yr)~ED@So0dfhX-UJ0VEKXS%7?|TBQeeM;+6JID87Lis
zC-6Yw%mEHVP!#}H11e8I<BK3|ptJ<_19J-0cn}|3T!QilNDsES1f^H79B6hJY#oFL
zBKe_l108+`yMffW1XTj{Adf@lpE2SR)Bpy#y8vnY3uHG4gPa4B2elVKaRm~CVNkq+
z<UrwtE(bCXBnR?0x*UiPk^}i0#0HrIOCONVKB8>}k{{^w0SW_<f8gl@6!9PoNgtrJ
z0m9(8fu#?SGzf$AfzlZ$eSqQt#K)RGVDSv1K>-2_WCjKXeo(pq^D*-}e*?&MAV~-f
zGN07+0kU#Gh3Nwn0HC-6xdetm-T=ijsN6)C1Gy6<2O2*^mjm%Za-gvZ5F2C;BeWlo
zTb$|O3>v-!6(mrLKxTpG2jJrv6&1R<#hI`f2M`ma6r>K6jzM{x2jpOArUHq>;s`XV
z1>-}fY{2mfk}q>{0T~15!}1hJJt$^C<t0b~C?-H|28n|(tc?ot6O2#Fc(nskz66;8
zN{1jjKp4aawKYL(kewhts6PVYgX{wFL16>pgXCeDQ#mmur6{$yST{K}C#RS}xj3^b
z70S-dPf5*TNY2kKNG!=r%1LENNiNbYNGwXtD`9{&<qhC0Lk7sOg#nZ{WJpOZ%S=v<
zFR3g@WhhEbXGqS;PtMj&D@rXaP0dTLWGKnZO-)KHPDK*Rgia3TWag#nf}FyTf*}G^
zgCY&#Bo`sARscIUF*zCJx!lx}jQkXaywr*k-JI02)EtPZ3<Vj9c_}%m4A@o<Fn~ft
zH#09KwE}Du$P3Cy3c=w8=NBWH0S%+lywc*-6y4Ii%#vb;%#@r|-IV;QREFY`#JrTG
zN`|7uy!6y!hP={T-I5C3<c!2T2&V|fft#(Hn^?f044NnaIjNW-B{vaF=;kHnrWP|K
zCFW)8mS?7vWH96;CV`?Xxd<XyoLW+nnU`M7P?lL#Qks~f3-Uv9X%Q$2L6Z)tDGZ<v
zHFBV3Bo^!Drex+b<m4wO=IDZY(9jgZkeisJ3yD)O6YA)^)EqDu>TC$NLN~1_F&7$z
zMHRYfnQ8fu_$)!@Aj{~cXQrnz6l7HDg3=v?kyyY0?yJD8g>XPY1+oUz<%PNj#Doch
ze2|$}mReMjnxb1=l9*hio1e@863t63hYA#zB<2?+Gk`n_GrOQDGdHoQk|8ItC_Pm-
zGcPH>G%rQBJTosPzr2_sH7_wKClyqh=w{@DvO;d6E;Is@N{b;(q!f^wSfHDmSe(sJ
jkY7~70Gi_mC3J?|;!NF?#F9iX11yh-<K+C(yb=ZgAoFyD

diff --git a/pc-bios/dtb/meson.build b/pc-bios/dtb/meson.build
index 9fcdbeff14..29b260ac2c 100644
--- a/pc-bios/dtb/meson.build
+++ b/pc-bios/dtb/meson.build
@@ -1,13 +1,13 @@
-dtbs = [
-  'bamboo.dtb',
-  'canyonlands.dtb',
-  'petalogix-ml605.dtb',
-  'petalogix-s3adsp1800.dtb',
+dts_sources = [
+  'bamboo.dts',
+  'canyonlands.dts',
+  'petalogix-s3adsp1800.dts',
+  'petalogix-ml605.dts',
 ]
 
 if dtc.found()
-  foreach out : dtbs
-    f = fs.replace_suffix(out, '.dts')
+  foreach f : dts_sources
+    out = fs.replace_suffix(f, '.dtb')
     custom_target(out,
         build_by_default: have_system,
         input: files(f),
@@ -17,6 +17,4 @@ if dtc.found()
         command: [ dtc, '-q', '-I', 'dts', '-O', 'dtb',
                         '-o', '@OUTPUT@', '@INPUT0@' ])
   endforeach
-else
-    install_data(dtbs, install_dir: qemu_datadir / 'dtb')
 endif
diff --git a/pc-bios/dtb/petalogix-ml605.dtb b/pc-bios/dtb/petalogix-ml605.dtb
deleted file mode 100644
index 9a05434db7f622d1b598d2cf1415c867cf7f5cc6..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 9882
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

diff --git a/pc-bios/dtb/petalogix-s3adsp1800.dtb b/pc-bios/dtb/petalogix-s3adsp1800.dtb
deleted file mode 100644
index 2513599438bffca96a93e877a1981efdd1a91115..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 8161
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
J8%PAM4*(cloX-FN

-- 
2.50.0


